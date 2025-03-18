import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14.0,
      height: 14.0,
      child: CircularProgressIndicator(color: AppColor.white, strokeWidth: 1.5),
    );
  }
}
