import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momentsy/app/bindings/app_binding.dart';
import 'package:momentsy/app/data/services/local/notification_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';
import 'package:momentsy/app/routes/app_pages.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  await initApp();
  final userId = SharedPreferencesService.getUserIds;
  if (userId.isNotEmpty) {
    Get.put(SocketService(userId: userId), permanent: true);
  } else {
    print(
      "⚠️ Không thể khởi tạo SocketService, userId null. Vui lòng đăng nhập.",
    );
  }
  runApp(MyApp());
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  //set up ở đây để dùng cho timeago cho card trong home
  await dotenv.load(fileName: ".env");
  timeago.setLocaleMessages('vi', timeago.ViMessages());

  await SharedPreferencesService.init();
  await NotificationService.requestPermissions(); // Xin quyền thông báo
  await NotificationService.init();
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
        textTheme: GoogleFonts.interTextTheme(),
        primaryColor: AppColor.primary,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColor.primary,
          onPrimary: AppColor.white,
          secondary: AppColor.grey,
          onSecondary: AppColor.grey,
          error: AppColor.red,
          onError: AppColor.white,
          surface: AppColor.white,
          onSurface: AppColor.k1A1C1E,
        ),
      ),
    );
  }
}
