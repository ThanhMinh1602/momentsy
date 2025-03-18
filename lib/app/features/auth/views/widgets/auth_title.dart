import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_style.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyle.bold18),
        SizedBox(height: 12.0),
        Text(subTitle, style: AppStyle.medium12),
      ],
    );
  }
}
