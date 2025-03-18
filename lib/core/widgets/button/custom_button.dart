import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/widgets/progess/custom_circular_progress.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.btnText,
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final String btnText;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      child: isLoading
          ? CustomCircularProgress()
          : Text(
              btnText,
              style: AppStyle.medium14.copyWith(color: AppColor.white),
            ),
    );
  }
}
