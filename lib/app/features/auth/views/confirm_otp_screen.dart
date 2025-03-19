import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/auth/views/widgets/auth_title.dart';
import 'package:momentsy/app/features/auth/views/widgets/base_screen_auth_widget.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: space24,
        children: [
          AuthTitle(
            title: 'Kiểm tra email của bạn!',
            subTitle:
                'Chúng tôi đã gửi liên kết đặt lại đến ${Get.arguments} nhập mã 4 chữ số được đề cập trong email',
          ),
          CustomOtpField(controller: otpController),
          CustomButton(btnText: 'Xác thực mã', onPressed: verifyOtp),
        ],
      ),
    );
  }
}
