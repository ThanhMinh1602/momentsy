class ValidatorUtils {
  static String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng không bỏ trống';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return 'Email không hợp lệ';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }

    String passwordPattern = r'^(?=.*[a-zA-Z])(?=.*\d).+$';
    RegExp regExp = RegExp(passwordPattern);

    if (!regExp.hasMatch(value)) {
      return 'Mật khẩu phải chứa ít nhất 1 chữ cái và 1 số';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu';
    }

    if (value != password) {
      return 'Mật khẩu nhập lại không khớp';
    }

    return null;
  }
}
