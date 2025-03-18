class ResetPasswordBody {
  final String resetToken;
  final String newPassword;

  ResetPasswordBody(this.resetToken, this.newPassword);

  Map<String, dynamic> toJson() {
    return {"resetToken": resetToken, "newPassword": newPassword};
  }
}
