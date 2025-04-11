import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/auth/views/widgets/auth_switch_text.dart';
import 'package:momentsy/app/features/auth/views/widgets/auth_title.dart';
import 'package:momentsy/app/features/auth/views/widgets/base_screen_auth_widget.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:momentsy/core/widgets/button/custom_button.dart';
import 'package:momentsy/core/widgets/textfield/custom_textield.dart';
import 'package:momentsy/app/data/body/login_body.dart';
import 'package:momentsy/app/features/auth/viewmodels/auth_view_model.dart';
import 'package:momentsy/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.find<AuthViewModel>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final email = Get.arguments;
    emailController.text = email ?? '';
    super.initState();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      final loginBody = LoginBody(
        emailController.text.trim(),
        passwordController.text,
      );
      authController.login(loginBody);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return BaseScreenAuthWidget(
      isLogin: true,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: space32),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isKeyboardOpen ? 0 : context.width * 0.25,
              height: isKeyboardOpen ? 0 : context.width * 0.25,
              child: Image.asset(Assets.icons.appicon.path, fit: BoxFit.cover),
            ),
            const SizedBox(height: space24),
            AuthTitle(
              title: 'Đăng nhập',
              subTitle: 'Nhập email và mật khẩu của bạn để đăng nhập',
            ),
            const SizedBox(height: space24),
            _buildLoginForm(),
            const SizedBox(height: space24),
            Obx(
              () => CustomButton(
                isLoading: authController.isLoading.value,
                btnText: 'Đăng nhập',
                isGradient: true,
                onPressed: login,
              ),
            ),
            const SizedBox(height: space24),
            if (!isKeyboardOpen) ...[
              _buildLoginWith(),
              const SizedBox(height: space16),
              _buildSocialMethod(),
              const SizedBox(height: space24),
              AuthSwitchText(
                leftText: 'Bạn chưa có tài khoản?',
                rightText: 'Đăng ký',
                onTap: () => Get.toNamed(AppRoutes.REGISTER),
              ),
              const SizedBox(height: space32),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMethod() {
    return Wrap(
      spacing: 15.0,
      runSpacing: 15.0,
      children: [
        _buildSocialMethodItem(icon: Assets.icons.google),
        _buildSocialMethodItem(icon: Assets.icons.facebook),
        _buildSocialMethodItem(icon: Assets.icons.apple),
        _buildSocialMethodItem(icon: Assets.icons.mobile),
      ],
    );
  }

  Widget _buildSocialMethodItem({
    required String icon,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(borderRadius10),
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }

  Widget _buildLoginWith() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColor.grey.withOpacity(0.3),
            endIndent: 16.0,
            thickness: 1,
          ),
        ),
        Text(
          'Đăng nhập bằng',
          style: AppStyle.regular12.copyWith(color: AppColor.textSecondary),
        ),
        Expanded(
          child: Divider(
            color: AppColor.grey.withOpacity(0.3),
            indent: 16.0,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextfiled(controller: emailController, hintText: 'Email'),

          SizedBox(height: space16),
          CustomTextfiled(
            controller: passwordController,
            hintText: 'Mật khẩu',
            isPassword: true,
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.FORGOTPASSWORD),
              child: Text('Quên mật khẩu ?', style: AppStyle.semiBold12),
            ),
          ),
        ],
      ),
    );
  }
}
