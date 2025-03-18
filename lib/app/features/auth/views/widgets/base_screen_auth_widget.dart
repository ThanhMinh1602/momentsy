import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/widgets/background/custom_background.dart';

class BaseScreenAuthWidget extends StatelessWidget {
  const BaseScreenAuthWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            CustomBackground(),
            Center(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16.0).copyWith(
                    top: MediaQuery.of(context).padding.top + space24,
                    bottom: MediaQuery.of(context).padding.bottom + space24),
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: AppColor.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(borderRadius12),
                    border: Border.all(color: AppColor.white, width: 1.0)),
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
