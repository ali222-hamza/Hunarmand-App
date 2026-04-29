import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/local/database_helper.dart';
import '../data/models/user_model.dart';

// AUTH VIEWMODEL
// This is the brain of the login/register system
// It stores the current logged-in user and tells all screens about them
// Every screen that needs user data reads from here
class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _db = DatabaseHelper.instance;

  // The current logged in user - null if no one is logged in
  UserModel? _currentUser;

  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedRole = '';

  // GETTERS - screens use these to read data
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedRole => _selectedRole;
  bool get isLoggedIn => _currentUser != null;

  // Helper getters so screens can directly get name, role etc
  // These return empty string instead of crashing if user is null
  String get userName => _currentUser?.fullName ?? '';
  String get userRole => _currentUser?.role ?? '';
  String get userEmail => _currentUser?.email ?? '';
  String get userPhone => _currentUser?.phone ?? '';
  double get userBalance => _currentUser?.walletBalance ?? 0.0;
  bool get userIsVerified => _currentUser?.isVerified ?? false;

  void setRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

  // REGISTER - creates a new account
  Future<bool> registerUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Step 1: Create account in Firebase Authentication
      UserCredential credential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      String uid = credential.user!.uid;
      String now = DateTime.now().toIso8601String();

      // Step 2: Build user object with all info
      UserModel newUser = UserModel(
        uid: uid,
        fullName: fullName.trim(),
        email: email.trim(),
        phone: phone.trim(),
        role: role,
        isVerified: false,
        walletBalance: 0.0,
        rating: 0.0,
        jobsDone: 0,
        createdAt: now,
      );

      // Step 3: Save to Firestore (cloud - accessible from any device)
      await _firestore
          .collection('users')
          .doc(uid)
          .set(newUser.toMap());

      // Step 4: Save to SQLite (local phone storage - works offline)
      await _db.insertUser(newUser);

      // Step 5: Set as current user so all screens update immediately
      _currentUser = newUser;
      _isLoading = false;
      notifyListeners(); // tells all listening screens to rebuild
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getAuthError(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Something went wrong. Please try again.';
      notifyListeners();
      return false;
    }
  }

  // LOGIN - signs in existing user
  // KEY FIX: Always fetches from Firebase first to get latest name and role
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    _currentUser = null; // clear old user first
    notifyListeners();

    try {
      // Step 1: Authenticate with Firebase Auth
      UserCredential credential =
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      String uid = credential.user!.uid;

      // Step 2: ALWAYS fetch fresh user data from Firestore
      // This ensures name, role and all info is up to date
      // This also fixes the admin bug - role is always fresh from cloud
      bool fetchedFromCloud = false;

      try {
        DocumentSnapshot doc =
        await _firestore.collection('users').doc(uid).get();

        if (doc.exists && doc.data() != null) {
          Map<String, dynamic> data =
          doc.data() as Map<String, dynamic>;

          // Build user from Firestore data
          _currentUser = UserModel.fromMap(data);
          fetchedFromCloud = true;

          // Update local SQLite with fresh cloud data
          // So offline access also shows correct name
          await _db.insertUser(_currentUser!);
        }
      } catch (cloudError) {
        // Firebase failed - try local SQLite as backup
        debugPrint('Cloud fetch failed, trying local: $cloudError');
      }

      // If cloud fetch failed, try local database
      if (!fetchedFromCloud || _currentUser == null) {
        _currentUser = await _db.getUserByUid(uid);
      }

      if (_currentUser == null) {
        // User exists in Auth but no profile data found
        _errorMessage =
        'Account data not found. Please contact support.';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _isLoading = false;
      notifyListeners(); // all screens rebuild with new user data
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getAuthError(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Something went wrong. Please try again.';
      notifyListeners();
      return false;
    }
  }

  // Called when app opens to check if user was already logged in
  Future<void> checkLoginStatus() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return;

    String uid = firebaseUser.uid;

    // Try cloud first for fresh data
    try {
      DocumentSnapshot doc =
      await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        _currentUser = UserModel.fromMap(
            doc.data() as Map<String, dynamic>);
        await _db.insertUser(_currentUser!);
        notifyListeners();
        return;
      }
    } catch (e) {
      debugPrint('Cloud check failed: $e');
    }

    // Fallback to local
    _currentUser = await _db.getUserByUid(uid);
    notifyListeners();
  }

  // Update user name locally and in cloud
  Future<void> updateUserName(String newName) async {
    if (_currentUser == null) return;
    try {
      await _firestore
          .collection('users')
          .doc(_currentUser!.uid)
          .update({'fullName': newName});

      _currentUser = _currentUser!.copyWith(fullName: newName);
      await _db.insertUser(_currentUser!);
      notifyListeners();
    } catch (e) {
      debugPrint('Update name error: $e');
    }
  }

  // Update wallet balance
  Future<void> updateBalance(double newBalance) async {
    if (_currentUser == null) return;
    _currentUser =
        _currentUser!.copyWith(walletBalance: newBalance);
    notifyListeners();
  }

  Future<bool> sendPasswordReset(String email) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Could not send reset email.';
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _currentUser = null;
    _selectedRole = '';
    notifyListeners();
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Convert Firebase error codes to readable messages
  String _getAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect password. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait a moment.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}