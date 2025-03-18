import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';

class CustomOtpField extends StatefulWidget {
  final TextEditingController controller;

  const CustomOtpField({super.key, required this.controller});

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: OtpTextField(
        textStyle: AppStyle.medium12,
        numberOfFields: 6,
        showFieldAsBox: true,
        filled: true,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        borderRadius: BorderRadius.circular(borderRadius12),
        contentPadding: const EdgeInsets.all(12.0),
        fillColor: AppColor.white,
        onCodeChanged: (value) {
          widget.controller.text = value;
        },
        onSubmit: (otp) {
          widget.controller.text = otp;
        },
      ),
    );
  }
}
