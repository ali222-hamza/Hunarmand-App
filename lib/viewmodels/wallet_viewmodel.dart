import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/local/database_helper.dart';
import '../data/models/transaction_model.dart';

// Wallet ViewModel manages earnings and withdrawals
class WalletViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _db = DatabaseHelper.instance;

  double _balance = 0.0;
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  double _withdrawAmount = 0.0;
  String _selectedPaymentMethod = 'JazzCash';

  double get balance => _balance;
  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  double get withdrawAmount => _withdrawAmount;
  String get selectedPaymentMethod => _selectedPaymentMethod;

  void setWithdrawAmount(double amount) {
    _withdrawAmount = amount;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  // Load wallet balance and transactions for a user
  Future<void> loadWallet(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load from local database first
      _transactions = await _db.getUserTransactions(userId);
      notifyListeners();

      // Then sync from Firestore
      QuerySnapshot snapshot = await _firestore
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      _transactions = snapshot.docs
          .map((doc) => TransactionModel.fromMap(
          doc.data() as Map<String, dynamic>))
          .toList();

      // Get balance from Firestore
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        Map<String, dynamic> data =
        userDoc.data() as Map<String, dynamic>;
        _balance = (data['walletBalance'] ?? 0.0).toDouble();
      }
    } catch (e) {
      debugPrint('Error loading wallet: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Process a withdrawal request
  Future<bool> processWithdrawal(String userId) async {
    if (_withdrawAmount <= 0 || _withdrawAmount > _balance) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      String now = DateTime.now().toIso8601String();
      String txId = 'TX${DateTime.now().millisecondsSinceEpoch}';

      TransactionModel transaction = TransactionModel(
        transactionId: txId,
        userId: userId,
        type: 'debit',
        amount: _withdrawAmount,
        description: 'Withdrawal to $_selectedPaymentMethod',
        status: 'completed',
        createdAt: now,
      );

      // Save to cloud
      await _firestore
          .collection('transactions')
          .doc(txId)
          .set(transaction.toMap());

      // Save to local
      await _db.insertTransaction(transaction);

      // Update balance in cloud
      double newBalance = _balance - _withdrawAmount;
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'walletBalance': newBalance});

      // Update balance in local db
      await _db.updateWalletBalance(userId, newBalance);

      _balance = newBalance;
      _transactions.insert(0, transaction);
      _withdrawAmount = 0.0;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Withdrawal error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}