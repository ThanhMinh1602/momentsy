import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/splash/viewmodels/splash_view_model.dart';
import 'package:momentsy/core/widgets/background/custom_background.dart';
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
    return Stack(
      children: [
        CustomBackground(),
        Center(child: SvgPicture.asset(Assets.icons.logo, width: 60.0)),
      ],
    );
  }
}
