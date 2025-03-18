import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/utils/validator_utils.dart';
import 'package:momentsy/core/widgets/button/custom_button.dart';
import 'package:momentsy/core/widgets/textfield/custom_textield.dart';
import 'package:momentsy/app/data/body/reset_password_body.dart';
import 'package:momentsy/app/features/auth/viewmodels/auth_view_model.dart';
import 'package:momentsy/app/features/auth/widgets/auth_title.dart';
import 'package:momentsy/app/features/auth/widgets/base_screen_auth_widget.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});
  final _authController = Get.find<AuthController>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void resetPassword() {
    if (_formKey.currentState!.validate()) {
      _authController.resetPassword(
        ResetPasswordBody(
          Get.arguments,
          _confirmPasswordController.text.trim(),
        ),
      );
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
              title: 'Cập nhật lại mật khẩu',
              subTitle:
                  'Tạo mật khẩu mới. Đảm bảo mật khẩu này khác với mật khẩu trước đó để bảo mật',
            ),
            CustomTextfiled(
              hintText: 'Nhập mật khẩu mới',
              controller: _passwordController,
              isPassword: true,
              validator: ValidatorUtils.validatePassword,
            ),
            CustomTextfiled(
              hintText: 'Nhập lại mật khẩu',
              controller: _confirmPasswordController,
              isPassword: true,
              validator:
                  (value) => ValidatorUtils.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
            ),
            Obx(
              () => CustomButton(
                btnText: 'Xong',
                isLoading: _authController.isLoading.value,
                onPressed: resetPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
