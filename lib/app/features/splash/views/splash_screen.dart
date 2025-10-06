import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/splash/viewmodels/splash_view_model.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:momentsy/gen/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Get.find<SplashViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          Assets.icons.appiconsvg,
          width: context.getWidth * 0.2,
        ),
      ),
    );
  }
}
