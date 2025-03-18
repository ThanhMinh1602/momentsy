import 'package:momentsy/app/data/models/user_model.dart';

class FriendRequestModel {
  final String id;
  final UserModel senderBy;
  final String receiverId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  FriendRequestModel({
    required this.id,
    required this.senderBy,
    required this.receiverId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // ✅ Chuyển JSON thành object
  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      id: json['id'],
      senderBy:
          UserModel.fromJson(json['senderBy']), // Đổi senderId -> senderBy
      receiverId: json['receiverId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // ✅ Chuyển object thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderBy': senderBy.toJson(),
      'receiverId': receiverId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
