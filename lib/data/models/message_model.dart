// This model stores a single chat message
class MessageModel {
  final int? id;
  final String messageId;
  final String chatId;      // combination of senderId + receiverId
  final String senderId;
  final String receiverId;
  final String text;
  final bool isRead;
  final String createdAt;

  MessageModel({
    this.id,
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    this.isRead = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'messageId': messageId,
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'isRead': isRead ? 1 : 0,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      messageId: map['messageId'] ?? '',
      chatId: map['chatId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      isRead: (map['isRead'] ?? 0) == 1,
      createdAt: map['createdAt'] ?? '',
    );
  }
}