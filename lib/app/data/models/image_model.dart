import 'package:momentsy/app/data/models/user_model.dart';

class ImageModel {
  final String? id;
  final String? fileId;
  final String? fileName;
  final String? mimeType;
  final String? viewLink;
  final String? downloadLink;
  final UserModel? uploadedBy;
  final DateTime? uploadedAt;

  ImageModel({
    this.id,
    this.fileId,
    this.fileName,
    this.mimeType,
    this.viewLink,
    this.downloadLink,
    this.uploadedBy,
    this.uploadedAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as String?,
      fileId: json['fileId'] as String?,
      fileName: json['fileName'] as String?,
      mimeType: json['mimeType'] as String?,
      viewLink: json['viewLink'] as String?,
      downloadLink: json['downloadLink'] as String?,
      uploadedBy:
          json['uploadedBy'] != null
              ? UserModel.fromJson(json['uploadedBy'])
              : null,
      uploadedAt:
          json['uploadedAt'] != null
              ? DateTime.parse(json['uploadedAt'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileId': fileId,
      'fileName': fileName,
      'mimeType': mimeType,
      'viewLink': viewLink,
      'downloadLink': downloadLink,
      'uploadedBy': uploadedBy?.toJson(),
      'uploadedAt': uploadedAt?.toIso8601String(),
    };
  }
}
