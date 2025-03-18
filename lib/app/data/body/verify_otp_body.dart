class VerifyOtpBody {
  final String email;
  final String otp;

  VerifyOtpBody({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}
