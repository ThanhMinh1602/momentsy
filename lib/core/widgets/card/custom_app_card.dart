import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';

class CustomAppCard extends StatelessWidget {
  const CustomAppCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColor.white,
    this.padding,
    this.borderRadius,
  });
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,

        borderRadius: BorderRadius.circular(borderRadius12),
      ),
      child: child,
    );
  }
}
