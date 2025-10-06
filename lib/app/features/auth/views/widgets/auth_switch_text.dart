import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';

class AuthSwitchText extends StatelessWidget {
  const AuthSwitchText({
    super.key,
    this.onTap,
    required this.leftText,
    required this.rightText,
  });
  final void Function()? onTap;
  final String leftText;
  final String rightText;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: leftText,
            style: TextStyle(fontSize: 14, color: AppColor.textSecondary),
          ),
          WidgetSpan(child: SizedBox(width: 6.0)),
          TextSpan(
            text: rightText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
