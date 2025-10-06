import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/gen/assets.gen.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({super.key, this.size, this.strokeWidth});
  final double? size;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 60.0,
      height: size ?? 60.0,
      child: Lottie.asset(Assets.lotties.loading)
    );
  }
}
