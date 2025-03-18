// app_pages.dart

import 'package:get/get.dart';
import 'package:momentsy/app/features/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.SPLASH, page: () => SplashPage()),
    // GetPage(
    //   name: AppRoutes.HOME,
    //   page: () => HomePage(),
    //   binding: HomeBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.LOGIN,
    //   transition: Transition.rightToLeft,
    //   page: () => LoginPage(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.REGISTER,
    //   transition: Transition.rightToLeft,
    //   page: () => RegisterPage(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.FORGOTPASSWORD,
    //   transition: Transition.rightToLeft,
    //   page: () => ForgotPasswordPage(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.CONFIRMOTP,
    //   transition: Transition.rightToLeft,
    //   page: () => ConfirmOtpPage(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.RESETPASSWORD,
    //   transition: Transition.rightToLeft,
    //   page: () => ResetPasswordPage(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.MAIN,
    //   page: () => MainPage(),
    //   bindings: [
    //     HomeBinding(),
    //     AppCameraBinding(),
    //     AppBinding(),
    //     AuthBinding(),
    //     SettingBinding(),
    //   ],
    // ),
    // GetPage(
    //   name: AppRoutes.CAMERA,
    //   transition: Transition.leftToRight,
    //   page: () => CameraPage(),
    //   binding: AppCameraBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.SETTING,
    //   transition: Transition.leftToRight,
    //   page: () => SettingPage(),
    //   binding: SettingBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.CHATBOX,
    //   page: () => ChatBoxScreen(),
    //   transition: Transition.rightToLeft,
    //   binding: ChatBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.PROFILE,
    //   page: () => ProfilePage(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: AppRoutes.SCANQR,
    //   page: () => ScanQrPage(),
    //   transition: Transition.rightToLeft,
    //   binding: SettingBinding(),
    // ),
  ];
}
