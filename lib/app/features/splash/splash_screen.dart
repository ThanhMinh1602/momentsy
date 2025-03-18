import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/widgets/background/custom_background.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/gen/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
      () => Get.offAllNamed(
        SharedPreferencesService.getToken() != null
            ? AppRoutes.MAIN
            : AppRoutes.LOGIN,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBackground(),
        Center(child: SvgPicture.asset(Assets.icons.logo, width: 60.0)),
      ],
    );
  }
}
