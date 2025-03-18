import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/widgets/button/custom_button.dart';
import 'package:momentsy/core/widgets/textfield/custom_textield.dart';
import 'package:momentsy/app/data/body/login_body.dart';
import 'package:momentsy/app/features/auth/viewmodels/auth_view_model.dart';
import 'package:momentsy/app/features/auth/widgets/auth_switch_text.dart';
import 'package:momentsy/app/features/auth/widgets/auth_title.dart';
import 'package:momentsy/app/features/auth/widgets/base_screen_auth_widget.dart';
import 'package:momentsy/gen/assets.gen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.find<AuthController>();

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
    return BaseScreenAuthWidget(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: space24,
          children: [
            SvgPicture.asset(Assets.icons.logo),
            AuthTitle(
              title: 'Đăng nhập',
              subTitle: 'Nhập email và mật khẩu của bạn để đăng nhập',
            ),
            _buildLoginForm(),
            Obx(
              () => CustomButton(
                isLoading: authController.isLoading.value,
                btnText: 'Đăng nhập',
                onPressed: login,
              ),
            ),
            _buildLoginWith(),
            _buildSocialMethod(),
            AuthSwitchText(
              leftText: 'Bạn chưa có tài khoản?',
              rightText: 'Đăng ký',
              onTap: () => Get.toNamed(AppRoutes.REGISTER),
            ),
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
          color: AppColor.white,
          border: Border.all(color: AppColor.kEFF0F6),
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
          child: Divider(color: AppColor.white, endIndent: 16.0, thickness: 1),
        ),
        Text('Đăng nhập bằng', style: AppStyle.regular12),
        Expanded(
          child: Divider(color: AppColor.white, indent: 16.0, thickness: 1),
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
          SizedBox(height: 6.0),
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
