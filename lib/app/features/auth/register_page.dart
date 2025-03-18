import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/utils/validator_utils.dart';
import 'package:momentsy/core/widgets/button/custom_button.dart';
import 'package:momentsy/core/widgets/textfield/custom_textield.dart';
import 'package:momentsy/app/data/body/register_body.dart';
import 'package:momentsy/app/features/auth/viewmodels/auth_view_model.dart';
import 'package:momentsy/app/features/auth/widgets/auth_switch_text.dart';
import 'package:momentsy/app/features/auth/widgets/auth_title.dart';
import 'package:momentsy/app/features/auth/widgets/base_screen_auth_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final authController = Get.find<AuthController>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void register() {
    if (_formKey.currentState!.validate()) {
      final String name =
          '${firstNameController.text.trim()} ${lastNameController.text.trim()}';
      final String email = emailController.text.trim();
      final String password = passwordController.text;
      authController.register(RegisterBody(name, email, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenAuthWidget(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: space24,
          children: [
            AuthTitle(title: 'Đăng ký', subTitle: 'Tạo tài khoản để tiếp tục!'),
            _buildRegisterForm(),
            Obx(
              () => CustomButton(
                isLoading: authController.isLoading.value,
                btnText: 'Đăng ký',
                onPressed: register,
              ),
            ),
            AuthSwitchText(
              leftText: 'Bạn đã có tài khoản?',
              rightText: 'Đăng nhập',
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        spacing: space6,
        children: [
          CustomTextfiled(controller: firstNameController, hintText: 'Họ'),
          CustomTextfiled(controller: lastNameController, hintText: 'Tên'),
          CustomTextfiled(
            controller: emailController,
            hintText: 'Email',
            validator: ValidatorUtils.validateEmail,
          ),
          CustomTextfiled(
            controller: passwordController,
            isPassword: true,
            hintText: 'Mật khẩu',
            validator: ValidatorUtils.validatePassword,
          ),
          CustomTextfiled(
            controller: confirmPasswordController,
            isPassword: true,
            hintText: 'Xác nhận mật khẩu',
            validator:
                (value) => ValidatorUtils.validateConfirmPassword(
                  value,
                  passwordController.text,
                ),
          ),
        ],
      ),
    );
  }
}
