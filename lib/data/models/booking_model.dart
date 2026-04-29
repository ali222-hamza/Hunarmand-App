// This model stores booking info when a customer books a worker
class BookingModel {
  final int? id;
  final String bookingId;
  final String customerId;
  final String workerId;
  final String workerName;
  final String serviceType;
  final String bookingDate;
  final String bookingTime;
  final String address;
  final String? notes;
  final String status; // pending, confirmed, in_progress, completed, cancelled
  final double amount;
  final String createdAt;

  BookingModel({
    this.id,
    required this.bookingId,
    required this.customerId,
    required this.workerId,
    required this.workerName,
    required this.serviceType,
    required this.bookingDate,
    required this.bookingTime,
    required this.address,
    this.notes,
    required this.status,
    required this.amount,
    required this.createdAt,
  });

  // Save to local database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookingId': bookingId,
      'customerId': customerId,
      'workerId': workerId,
      'workerName': workerName,
      'serviceType': serviceType,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'address': address,
      'notes': notes,
      'status': status,
      'amount': amount,
      'createdAt': createdAt,
    };
  }

  // Load from local database
  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      bookingId: map['bookingId'] ?? '',
      customerId: map['customerId'] ?? '',
      workerId: map['workerId'] ?? '',
      workerName: map['workerName'] ?? '',
      serviceType: map['serviceType'] ?? '',
      bookingDate: map['bookingDate'] ?? '',
      bookingTime: map['bookingTime'] ?? '',
      address: map['address'] ?? '',
      notes: map['notes'],
      status: map['status'] ?? 'pending',
      amount: (map['amount'] ?? 0.0).toDouble(),
      createdAt: map['createdAt'] ?? '',
    );
  }
}