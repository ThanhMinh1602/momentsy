import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          subTitle,
          style: TextStyle(fontSize: 14, color: AppColor.textSecondary),
        ),
      ],
    );
  }
}
