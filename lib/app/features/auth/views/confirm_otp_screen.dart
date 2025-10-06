import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/auth/views/widgets/auth_title.dart';
import 'package:momentsy/app/features/auth/views/widgets/base_screen_auth_widget.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/widgets/button/custom_button.dart';
import 'package:momentsy/core/widgets/textfield/custom_opt_field.dart';
import 'package:momentsy/app/data/body/verify_otp_body.dart';
import 'package:momentsy/app/features/auth/viewmodels/auth_view_model.dart';

class ConfirmOtpScreen extends StatefulWidget {
  const ConfirmOtpScreen({super.key});

  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> {
  final authController = Get.find<AuthViewModel>();
  final otpController = TextEditingController();

  void verifyOtp() {
    authController.verifyOtp(
      VerifyOtpBody(otp: otpController.text.trim(), email: Get.arguments),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenAuthWidget(
      title: 'Xác thực mã OTP',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: space24,
        children: [
          buildSubTitle(context),

          CustomOtpField(controller: otpController),
          CustomButton(
            isGradient: true,
            btnText: 'Xác thực mã',
            onPressed: verifyOtp,
          ),
        ],
      ),
    );
  }

  Padding buildSubTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            height: 1.6, // Giãn dòng nhẹ cho dễ đọc
            color: AppColor.textPrimary,
          ),
          children: [
            const TextSpan(text: 'Chúng tôi đã gửi mã xác thực đến email:\n'),
            TextSpan(
              text: '${Get.arguments}\n',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColor.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text: 'Vui lòng nhập mã xác thực bên dưới để tiếp tục.',
            ),
          ],
        ),
      ),
    );
  }
}
