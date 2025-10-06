class MessageModel {
  final String? id;
  final String? senderId;
  final String? receiverId;
  final String? content;
  final DateTime? timestamp;
  final String?  status;

  MessageModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.content,
    this.timestamp,
    this.status
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      timestamp:
          json['timestamp'] != null
              ? DateTime.tryParse(json['timestamp'])
              : null,
      status  : json['status']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
