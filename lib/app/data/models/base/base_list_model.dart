import 'package:momentsy/app/data/models/base/base_model.dart';

class BaseListModel<T> extends BaseModel<List<T>> {
  BaseListModel({
    required super.success,
    required super.message,
    super.data,
    super.error,
    required super.statusCode,
  });

  factory BaseListModel.fromJson(
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic>) itemFromJson,
  }) {
    return BaseListModel<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data:
          json['data']['body'] != null && json['data']['body'] is List
              ? (json['data']['body'] as List)
                  .map((item) => itemFromJson(item as Map<String, dynamic>))
                  .toList()
              : null,
      error: json['error'] as String?,
      statusCode: json['statusCode'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson({
    Map<String, dynamic>? Function(List<T>?)? dataToJson,
  }) {
    return {
      'success': success,
      'message': message,
      'data': data != null && dataToJson != null ? dataToJson(data) : null,
      'error': error,
      'statusCode': statusCode,
    };
  }
}
