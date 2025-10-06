import 'package:momentsy/app/data/models/message_model.dart';
import 'package:momentsy/app/data/models/user_model.dart';

class ConversationModel {
  final String id;
  final UserModel? friend;
  final MessageModel? lastMessage;

  ConversationModel({required this.id, this.friend, this.lastMessage});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String,
      friend:
          json['friend'] != null ? UserModel.fromJson(json['friend']) : null,
      lastMessage: MessageModel.fromJson(json['lastMessage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'friend': friend?.toJson(),
      'lastMessage': lastMessage?.toJson(),
    };
  }

  ConversationModel copyWith({
    String? id,
    UserModel? friend,
    MessageModel? lastMessage,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      friend: friend ?? this.friend,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
