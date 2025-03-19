// app_pages.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/auth/bindings/auth_binding.dart';
import 'package:momentsy/app/features/auth/views/confirm_otp_screen.dart';
import 'package:momentsy/app/features/auth/views/forgot_password_screen.dart';
import 'package:momentsy/app/features/auth/views/login_screen.dart';
import 'package:momentsy/app/features/auth/views/register_screen.dart';
import 'package:momentsy/app/features/auth/views/reset_password_screen.dart';
import 'package:momentsy/app/features/camera/bindings/camera_binding.dart';
import 'package:momentsy/app/features/camera/views/camera_screen.dart';
import 'package:momentsy/app/features/home/bindings/home_binding.dart';
import 'package:momentsy/app/features/home/views/home_screen.dart';
import 'package:momentsy/app/features/main/bindings/main_binding.dart';
import 'package:momentsy/app/features/main/views/main_screen.dart';
import 'package:momentsy/app/features/notification/bindings/notification_binding.dart';
import 'package:momentsy/app/features/setting/bindings/setting_binding.dart';
import 'package:momentsy/app/features/splash/bindings/splash_binding.dart';
import 'package:momentsy/app/features/splash/views/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    //Splash
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    //Auth
    GetPage(
      name: AppRoutes.LOGIN,
      transition: Transition.rightToLeft,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      transition: Transition.rightToLeft,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.FORGOTPASSWORD,
      transition: Transition.rightToLeft,
      page: () => ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.CONFIRMOTP,
      transition: Transition.rightToLeft,
      page: () => ConfirmOtpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.RESETPASSWORD,
      transition: Transition.rightToLeft,
      page: () => ResetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainScreen(),
      bindings: [
        MainBinding(),
        HomeBinding(),
        NotificationBinding(),
        SettingBinding(),
      ],
      children: [
        GetPage(
          name: AppRoutes.HOME,
          page: () => HomeScreen(),
          binding: HomeBinding(),
          children: [
            GetPage(
              name: AppRoutes.CAMERA,
              page: () => CameraScreen(),
              binding: CameraBinding(),
            ),
          ],
        ),
        GetPage(name: AppRoutes.CHATLIST, page: () => Container()),
        GetPage(name: AppRoutes.NOTIFICATION, page: () => Container()),
        GetPage(name: AppRoutes.SETTING, page: () => Container()),
      ],
    ),
  ];
}
