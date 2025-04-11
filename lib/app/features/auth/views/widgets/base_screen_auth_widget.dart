import 'package:flutter/material.dart';
import 'package:momentsy/app/features/auth/views/widgets/auth_title.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/widgets/appbar/custom_auth_appbar.dart';
import 'package:momentsy/core/widgets/background/custom_background.dart';

class BaseScreenAuthWidget extends StatelessWidget {
  const BaseScreenAuthWidget({
    super.key,
    required this.child,
    this.isLogin = false,
    this.title,
    this.subTitle,
  });
  final Widget child;
  final bool isLogin;
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: isLogin ? null : CustomAuthAppBar(title: title),
        backgroundColor: AppColor.white,
        body: Padding(
          padding: EdgeInsets.all(space24).copyWith(
            top: MediaQuery.of(context).padding.top + (isLogin ? space24 : 0),
            bottom: MediaQuery.of(context).padding.bottom + space24,
          ),
          child: child,
        ),
      ),
    );
  }
}
