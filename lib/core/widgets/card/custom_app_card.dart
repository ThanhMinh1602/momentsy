import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';

class CustomAppCard extends StatelessWidget {
  const CustomAppCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColor.white,
  });
  final Widget child;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(borderRadius12),
      ),
      child: child,
    );
  }
}
