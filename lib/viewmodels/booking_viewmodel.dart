import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/local/database_helper.dart';
import '../data/models/booking_model.dart';

// Booking ViewModel handles all job booking logic
class BookingViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _db = DatabaseHelper.instance;

  List<BookingModel> _bookings = [];
  bool _isLoading = false;
  String? _selectedDate;
  String? _selectedTime;
  String _notes = '';

  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get selectedDate => _selectedDate;
  String? get selectedTime => _selectedTime;
  String get notes => _notes;

  void selectDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setNotes(String value) {
    _notes = value;
    notifyListeners();
  }

  // Create a new booking and save it
  Future<bool> createBooking({
    required String customerId,
    required String workerId,
    required String workerName,
    required String serviceType,
    required String address,
    required double amount,
  }) async {
    if (_selectedDate == null || _selectedTime == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      String now = DateTime.now().toIso8601String();
      String bookingId =
          'BK${DateTime.now().millisecondsSinceEpoch}';

      BookingModel booking = BookingModel(
        bookingId: bookingId,
        customerId: customerId,
        workerId: workerId,
        workerName: workerName,
        serviceType: serviceType,
        bookingDate: _selectedDate!,
        bookingTime: _selectedTime!,
        address: address,
        notes: _notes.isEmpty ? null : _notes,
        status: 'pending',
        amount: amount,
        createdAt: now,
      );

      // Save to cloud
      await _firestore
          .collection('bookings')
          .doc(bookingId)
          .set(booking.toMap());

      // Save to local phone storage
      await _db.insertBooking(booking);

      _bookings.insert(0, booking);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load all bookings for a customer
  Future<void> loadCustomerBookings(String customerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Try local first
      _bookings = await _db.getCustomerBookings(customerId);
      notifyListeners();

      // Then sync from cloud
      QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .where('customerId', isEqualTo: customerId)
          .orderBy('createdAt', descending: true)
          .get();

      _bookings = snapshot.docs
          .map((doc) => BookingModel.fromMap(
          doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Keep local data if cloud fails
      debugPrint('Error loading bookings: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load all bookings for a worker
  Future<void> loadWorkerBookings(String workerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _bookings = await _db.getWorkerBookings(workerId);
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .where('workerId', isEqualTo: workerId)
          .orderBy('createdAt', descending: true)
          .get();

      _bookings = snapshot.docs
          .map((doc) => BookingModel.fromMap(
          doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error loading worker bookings: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update booking status
  Future<void> updateStatus(
      String bookingId, String newStatus) async {
    try {
      await _firestore
          .collection('bookings')
          .doc(bookingId)
          .update({'status': newStatus});

      await _db.updateBookingStatus(bookingId, newStatus);

      int index =
      _bookings.indexWhere((b) => b.bookingId == bookingId);
      if (index != -1) {
        BookingModel old = _bookings[index];
        _bookings[index] = BookingModel(
          id: old.id,
          bookingId: old.bookingId,
          customerId: old.customerId,
          workerId: old.workerId,
          workerName: old.workerName,
          serviceType: old.serviceType,
          bookingDate: old.bookingDate,
          bookingTime: old.bookingTime,
          address: old.address,
          notes: old.notes,
          status: newStatus,
          amount: old.amount,
          createdAt: old.createdAt,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating booking: $e');
    }
  }
}