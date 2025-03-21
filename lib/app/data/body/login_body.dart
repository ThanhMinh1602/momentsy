import 'package:momentsy/core/config/firebase/notification_service.dart';

class LoginBody {
  final String email;
  final String password;
  String? deviceToken = NotificationService().getDeviceToken();
  LoginBody(this.email, this.password);
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password, "deviceToken": deviceToken};
  }
}
