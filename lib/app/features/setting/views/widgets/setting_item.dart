import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    this.color = AppColor.textPrimary,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isLogout = false,
    this.iconColor,
  });
  final Color color;
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final bool isLogout;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: isLogout ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing:
          isLogout == false
              ? Icon(Icons.arrow_forward_ios, size: 16.0, color: AppColor.grey)
              : null,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
