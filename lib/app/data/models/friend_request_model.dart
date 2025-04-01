import 'package:momentsy/app/data/models/user_model.dart';

class FriendRequestModel {
  final String? id;
  final UserModel? senderBy;
  final String? receiverId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FriendRequestModel({
    this.id,
    this.senderBy,
    this.receiverId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      id: json['id'] as String?,
      senderBy:
          json['senderBy'] != null
              ? UserModel.fromJson(json['senderBy'])
              : null,
      receiverId: json['receiverId'] as String?,
      status: json['status'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderBy': senderBy?.toJson(),
      'receiverId': receiverId,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
