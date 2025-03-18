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
  });

  final bool isPassword;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  @override
  State<CustomTextfiled> createState() => _CustomTextfiledState();
}

class _CustomTextfiledState extends State<CustomTextfiled> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2.0,
            // ignore: deprecated_member_use
            color: AppColor.kE4E5E7.withOpacity(0.24),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? isHidden : false,
        style: AppStyle.medium14,
        validator: widget.validator ?? ValidatorUtils.isEmpty,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppStyle.medium14.copyWith(color: AppColor.kACB5BB),
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
                      color: AppColor.kACB5BB,
                    ),
                  )
                  : widget.suffixIcon,
          filled: true,
          fillColor: AppColor.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.5,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 1.0, color: AppColor.kEDF1F3),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 1.0, color: AppColor.kEDF1F3),
          ),
        ),
      ),
    );
  }
}
