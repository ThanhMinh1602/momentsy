import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_style.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    this.color = AppColor.white,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isLogout = false,
  });
  final Color color;
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final bool isLogout;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: AppStyle.regular14.copyWith(color: color)),
      trailing:
          isLogout == false
              ? Icon(Icons.arrow_forward_ios, size: 14.0, color: color)
              : null,
      onTap: onTap,
    );
  }
}
