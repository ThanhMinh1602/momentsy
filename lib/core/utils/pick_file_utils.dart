import 'dart:io';
import 'package:file_picker/file_picker.dart';

class PickFileUtils {
  static Future<File?> pickSingleFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  /// Chọn nhiều file cùng lúc
  static Future<List<File>> pickMultipleFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      return result.paths
          .whereType<String>()
          .map((path) => File(path))
          .toList();
    }
    return [];
  }

  /// Chọn file có loại cụ thể (ví dụ: chỉ PDF)
  static Future<File?> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  /// Chọn file có loại cụ thể (ví dụ: chỉ hình ảnh)
  static Future<File?> pickImageFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }
}
