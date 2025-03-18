import 'package:flutter/material.dart';
import 'package:momentsy/core/widgets/progess/custom_circular_progress.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child:
          isLoading
              ? CustomCircularProgress()
              : Text(
                text,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
    );
  }
}
