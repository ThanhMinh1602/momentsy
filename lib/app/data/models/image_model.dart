import 'package:momentsy/app/data/models/user_model.dart';

class ImageModel {
  final String id;
  final String fileId;
  final String fileName;
  final String mimeType;
  final String viewLink;
  final String downloadLink;
  final UserModel uploadedBy;
  final DateTime uploadedAt;

  ImageModel({
    required this.id,
    required this.fileId,
    required this.fileName,
    required this.mimeType,
    required this.viewLink,
    required this.downloadLink,
    required this.uploadedBy,
    required this.uploadedAt,
  });

  // ✅ Chuyển JSON thành object
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      fileId: json['fileId'],
      fileName: json['fileName'],
      mimeType: json['mimeType'],
      viewLink: json['viewLink'],
      downloadLink: json['downloadLink'],
      uploadedBy: UserModel.fromJson(json['uploadedBy']),
      uploadedAt: DateTime.parse(json['uploadedAt']),
    );
  }

  // ✅ Chuyển object thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileId': fileId,
      'fileName': fileName,
      'mimeType': mimeType,
      'viewLink': viewLink,
      'downloadLink': downloadLink,
      'uploadedBy': uploadedBy.toJson(), // Gọi toJson() của UserModel
      'uploadedAt':
          uploadedAt.toIso8601String(), // Chuyển DateTime thành chuỗi ISO
    };
  }
}
