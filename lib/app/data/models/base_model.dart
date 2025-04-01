class BaseModel<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;
  final int statusCode;

  BaseModel({
    required this.success,
    required this.message,
    this.data,
    this.error,
    required this.statusCode,
  });

  factory BaseModel.fromJson(
    Map<String, dynamic> json, {
    T? Function(Map<String, dynamic>)? dataFromJson,
  }) {
    return BaseModel<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data:
          json['data'] != null && dataFromJson != null
              ? dataFromJson(json['data'])
              : null,
      error: json['error'] as String?,
      statusCode: json['statusCode'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson({
    Map<String, dynamic>? Function(T?)? dataToJson,
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
