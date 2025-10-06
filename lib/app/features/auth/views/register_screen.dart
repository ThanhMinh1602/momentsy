import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/auth/views/widgets/auth_switch_text.dart';
import 'package:momentsy/app/features/auth/views/widgets/auth_title.dart';
import 'package:momentsy/app/features/auth/views/widgets/base_screen_auth_widget.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/utils/validator_utils.dart';
import 'package:momentsy/core/widgets/button/custom_button.dart';
import 'package:momentsy/core/widgets/textfield/custom_textield.dart';
import 'package:momentsy/app/data/body/register_body.dart';
import 'package:momentsy/app/features/auth/viewmodels/auth_view_model.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final authController = Get.find<AuthViewModel>();
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
      title: 'Đăng ký',

      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextfiled(
                      controller: firstNameController,
                      hintText: 'Họ',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextfiled(
                      controller: lastNameController,
                      hintText: 'Tên',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomTextfiled(
                controller: emailController,
                hintText: 'Email',
                validator: ValidatorUtils.validateEmail,
              ),
              const SizedBox(height: 12),
              CustomTextfiled(
                controller: passwordController,
                isPassword: true,
                hintText: 'Mật khẩu',
                validator: ValidatorUtils.validatePassword,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 24),
              Obx(
                () => CustomButton(
                  isGradient: true,
                  isLoading: authController.isLoading.value,
                  btnText: 'Đăng ký',
                  onPressed: register,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: AuthSwitchText(
                  leftText: 'Bạn đã có tài khoản?',
                  rightText: 'Đăng nhập',
                  onTap: () => Get.back(),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
