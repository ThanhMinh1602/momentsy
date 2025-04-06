import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/widgets/button/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String? cancelText;
  final String? confirmText;
  final bool isLoading;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.cancelText = 'Hủy',
    this.confirmText = 'Xác nhận',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColor.textPrimary,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(fontSize: 16, color: AppColor.textSecondary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: AppColor.textSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          child: Text(cancelText!, style: TextStyle(fontSize: 16)),
        ),
        CustomButton(
          isLoading: isLoading,
          onPressed: () {
            onConfirm();
            if (isLoading == false) {
              Navigator.of(context).pop();
            }
          },
          btnText: 'Ok',
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: AppColor.surface,
      elevation: 4,
    );
  }
}
