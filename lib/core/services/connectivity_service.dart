import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/local/database_helper.dart';
import '../../data/models/user_model.dart';
import '../../data/models/booking_model.dart';
import '../../data/models/transaction_model.dart';

// This service checks internet connectivity and syncs data
// between SQLite (local) and Firebase (cloud)
class ConnectivityService {
  static final ConnectivityService instance =
  ConnectivityService._internal();
  ConnectivityService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _db = DatabaseHelper.instance;

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  // Checks if device has real internet by pinging Google DNS
  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      _isOnline =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      _isOnline = false;
    }
    return _isOnline;
  }

  // Fetch user from Firebase if online, from SQLite if offline
  Future<UserModel?> fetchUser(String uid) async {
    bool online = await checkInternet();

    if (online) {
      try {
        DocumentSnapshot doc =
        await _firestore.collection('users').doc(uid).get();
        if (doc.exists) {
          UserModel user = UserModel.fromMap(
              doc.data() as Map<String, dynamic>);
          // Always update local copy with fresh cloud data
          await _db.insertUser(user);
          return user;
        }
      } catch (e) {
        debugPrint('Firebase fetch error, using local: $e');
      }
    }

    // Offline fallback - get from SQLite
    return await _db.getUserByUid(uid);
  }

  // Fetch bookings - online from Firebase, offline from SQLite
  Future<List<BookingModel>> fetchCustomerBookings(
      String customerId) async {
    bool online = await checkInternet();

    if (online) {
      try {
        QuerySnapshot snap = await _firestore
            .collection('bookings')
            .where('customerId', isEqualTo: customerId)
            .orderBy('createdAt', descending: true)
            .get();

        List<BookingModel> bookings = snap.docs
            .map((d) => BookingModel.fromMap(
            d.data() as Map<String, dynamic>))
            .toList();

        // Save fresh data to local SQLite
        for (var b in bookings) {
          await _db.insertBooking(b);
        }
        return bookings;
      } catch (e) {
        debugPrint('Firebase bookings error: $e');
      }
    }

    return await _db.getCustomerBookings(customerId);
  }

  // Fetch worker bookings
  Future<List<BookingModel>> fetchWorkerBookings(
      String workerId) async {
    bool online = await checkInternet();

    if (online) {
      try {
        QuerySnapshot snap = await _firestore
            .collection('bookings')
            .where('workerId', isEqualTo: workerId)
            .orderBy('createdAt', descending: true)
            .get();

        List<BookingModel> bookings = snap.docs
            .map((d) => BookingModel.fromMap(
            d.data() as Map<String, dynamic>))
            .toList();

        for (var b in bookings) {
          await _db.insertBooking(b);
        }
        return bookings;
      } catch (e) {
        debugPrint('Firebase worker bookings error: $e');
      }
    }

    return await _db.getWorkerBookings(workerId);
  }

  // Sync all unsynced SQLite records to Firebase when back online
  // This pushes any data created while offline
  Future<void> syncLocalToFirebase() async {
    bool online = await checkInternet();
    if (!online) return;

    try {
      // Sync users
      List<UserModel> users = await _db.getAllUsers();
      for (UserModel user in users) {
        DocumentSnapshot doc = await _firestore
            .collection('users')
            .doc(user.uid)
            .get();
        if (!doc.exists) {
          await _firestore
              .collection('users')
              .doc(user.uid)
              .set(user.toMap());
          debugPrint('Synced user ${user.uid} to Firebase');
        }
      }

      // Sync bookings
      List<BookingModel> bookings = await _db.getAllBookings();
      for (BookingModel booking in bookings) {
        DocumentSnapshot doc = await _firestore
            .collection('bookings')
            .doc(booking.bookingId)
            .get();
        if (!doc.exists) {
          await _firestore
              .collection('bookings')
              .doc(booking.bookingId)
              .set(booking.toMap());
          debugPrint('Synced booking ${booking.bookingId}');
        }
      }

      // Sync transactions
      List<TransactionModel> txs =
      await _db.getAllTransactions();
      for (TransactionModel tx in txs) {
        DocumentSnapshot doc = await _firestore
            .collection('transactions')
            .doc(tx.transactionId)
            .get();
        if (!doc.exists) {
          await _firestore
              .collection('transactions')
              .doc(tx.transactionId)
              .set(tx.toMap());
          debugPrint('Synced transaction ${tx.transactionId}');
        }
      }

      debugPrint('Sync complete');
    } catch (e) {
      debugPrint('Sync error: $e');
    }
  }
}