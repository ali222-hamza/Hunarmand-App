// This model stores wallet transaction info
class TransactionModel {
  final int? id;
  final String transactionId;
  final String userId;
  final String type;       // "credit" or "debit"
  final double amount;
  final String description;
  final String status;     // completed, pending, failed
  final String createdAt;

  TransactionModel({
    this.id,
    required this.transactionId,
    required this.userId,
    required this.type,
    required this.amount,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionId': transactionId,
      'userId': userId,
      'type': type,
      'amount': amount,
      'description': description,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      transactionId: map['transactionId'] ?? '',
      userId: map['userId'] ?? '',
      type: map['type'] ?? 'credit',
      amount: (map['amount'] ?? 0.0).toDouble(),
      description: map['description'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: map['createdAt'] ?? '',
    );
  }
}