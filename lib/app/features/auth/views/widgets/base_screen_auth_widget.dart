import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/widgets/background/custom_background.dart';
import 'package:get/get.dart';

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
            Positioned(
              top: MediaQuery.of(context).padding.top + space12,
              left: space12,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadow,
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColor.textPrimary,
                    size: 20,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16.0).copyWith(
                  top: MediaQuery.of(context).padding.top + space24,
                  bottom: MediaQuery.of(context).padding.bottom + space24,
                ),
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(borderRadius12),
                  border: Border.all(
                    color: AppColor.grey.withOpacity(0.1),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.shadow,
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
