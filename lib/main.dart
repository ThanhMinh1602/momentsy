import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momentsy/app/bindings/app_binding.dart';
import 'package:momentsy/app/routes/app_pages.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/config/firebase/notification_service.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  await initApp();
  runApp(MyApp());
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  //set up ở đây để dùng cho timeago cho card trong home
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  await Firebase.initializeApp();
  await NotificationService().initFirebase();
  await SharedPreferencesService.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'momentsy'.toUpperCase(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          TextTheme(
            bodyLarge: TextStyle(color: AppColor.textPrimary),
            bodyMedium: TextStyle(color: AppColor.textPrimary),
            titleLarge: TextStyle(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(color: AppColor.textPrimary),
            labelLarge: TextStyle(color: AppColor.textPrimary),
          ),
        ),
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: AppColor.background,
        cardColor: AppColor.cardLight,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColor.primary,
          onPrimary: AppColor.white,
          secondary: AppColor.secondary,
          onSecondary: AppColor.white,
          error: AppColor.error,
          onError: AppColor.white,
          background: AppColor.background,
          onBackground: AppColor.textPrimary,
          surface: AppColor.surface,
          onSurface: AppColor.textPrimary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor.surface,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.grey,
          elevation: 8,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColor.surface,
          hintStyle: TextStyle(color: AppColor.textHint),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.grey.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.grey.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
