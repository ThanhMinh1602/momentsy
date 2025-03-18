class VerifyOtpModel {
  final String message;
  final String resetToken;

  VerifyOtpModel({
    required this.message,
    required this.resetToken,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      message: json['message'] ?? '',
      resetToken: json['resetToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'resetToken': resetToken,
    };
  }
}
