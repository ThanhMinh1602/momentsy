
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/utils/validator_utils.dart';
import 'package:momentsy/core/widgets/button/custom_button.dart';
import 'package:momentsy/core/widgets/textfield/custom_textield.dart';
import 'package:momentsy/app/features/auth/viewmodels/auth_view_model.dart';
import 'package:momentsy/app/features/auth/widgets/auth_title.dart';
import 'package:momentsy/app/features/auth/widgets/base_screen_auth_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  final authController = Get.find<AuthController>();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void sendOtp() {
    if (_formKey.currentState!.validate()) {
      authController.forgotPassword(emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenAuthWidget(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: space24,
          children: [
            AuthTitle(
              title: 'Quên mật khẩu',
              subTitle: 'Nhập email để tiếp tục!',
            ),
            CustomTextfiled(
              hintText: 'Email',
              controller: emailController,
              validator: ValidatorUtils.validateEmail,
            ),
            Obx(
              () => CustomButton(
                isLoading: authController.isLoading.value,
                btnText: 'Gửi',
                onPressed: sendOtp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
