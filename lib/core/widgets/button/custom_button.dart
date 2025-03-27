import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/widgets/progess/custom_circular_progress.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.btnText,
    this.isLoading = false,
    this.isPrimary = true,
    this.icon,
    this.gradientColors,
  });
  final void Function()? onPressed;
  final String btnText;
  final bool isLoading;
  final bool isPrimary;
  final Widget? icon;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    final defaultGradient = [AppColor.primary, AppColor.accent];

    return Container(
      decoration: BoxDecoration(
        gradient:
            isPrimary
                ? LinearGradient(
                  colors: gradientColors ?? defaultGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
        borderRadius: BorderRadius.circular(16.0),
        color: isPrimary ? null : AppColor.cardLight,
        boxShadow: [
          BoxShadow(
            color:
                isPrimary ? AppColor.primary.withOpacity(0.2) : AppColor.shadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          backgroundColor: Colors.transparent,
          foregroundColor: isPrimary ? AppColor.white : AppColor.textPrimary,
          minimumSize: Size(double.infinity, 56),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child:
            isLoading
                ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: isPrimary ? Colors.white : AppColor.primary,
                    strokeWidth: 2,
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, SizedBox(width: 12)],
                    Text(
                      btnText,
                      style: TextStyle(
                        color:
                            isPrimary ? AppColor.white : AppColor.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
