import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/widgets/textfield/custom_textield.dart';
import 'package:momentsy/gen/assets.gen.dart';

class CustomSendMessageField extends StatelessWidget {
  const CustomSendMessageField({
    super.key,
    this.hintText,
    this.onPressed,
    this.controller,
    this.focusNode,
  });
  final String? hintText;
  final void Function()? onPressed;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return CustomTextfiled(
      focusNode: focusNode,
      controller: controller,
      hintText: hintText ?? 'Send a message',
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(Assets.icons.send, color: AppColor.primary),
      ),
      validator: (value) {
        return null;
      },
    );
  }
}
