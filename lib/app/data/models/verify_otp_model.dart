class VerifyOtpModel {
  final String resetToken;

  VerifyOtpModel({required this.resetToken});

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(resetToken: json['resetToken'] as String? ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'resetToken': resetToken};
  }
}
