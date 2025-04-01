class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? avatar;

  UserModel({this.id, this.name, this.email, this.avatar});

  // ✅ Chuyển JSON thành object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  // ✅ Chuyển object thành JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'avatar': avatar};
  }
}
