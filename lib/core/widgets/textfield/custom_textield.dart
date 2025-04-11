import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/utils/validator_utils.dart';

class CustomTextfiled extends StatefulWidget {
  const CustomTextfiled({
    super.key,
    this.isPassword = false,
    required this.hintText,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.focusNode,
  });

  final bool isPassword;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  @override
  State<CustomTextfiled> createState() => _CustomTextfiledState();
}

class _CustomTextfiledState extends State<CustomTextfiled> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.isPassword ? isHidden : false,
        style: AppStyle.medium14.copyWith(color: AppColor.textPrimary),
        validator: widget.validator ?? ValidatorUtils.isEmpty,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppStyle.medium14.copyWith(color: AppColor.textHint),
          suffixIcon:
              widget.isPassword
                  ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    child: Icon(
                      isHidden ? Icons.visibility_off : Icons.visibility,
                      size: 16.0,
                      color: AppColor.primary,
                    ),
                  )
                  : widget.suffixIcon,
          filled: true,
          fillColor: AppColor.surface,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColor.grey.withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(width: 1.5, color: AppColor.primary),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColor.grey.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}
