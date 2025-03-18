class ChatBody {
  final String senderId;
  final String receiverId;
  final String message;

  ChatBody(this.senderId, this.receiverId, this.message);

  // Chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
    };
  }

  // Chuyển đổi từ JSON thành đối tượng ChatBody
  factory ChatBody.fromJson(Map<String, dynamic> json) {
    return ChatBody(
      json["senderId"] as String,
      json["receiverId"] as String,
      json["message"] as String,
    );
  }
}
