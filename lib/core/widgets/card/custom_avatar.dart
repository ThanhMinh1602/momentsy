import 'dart:io';

import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/gen/assets.gen.dart';

class CustomAvatar extends StatelessWidget {
  final dynamic image;
  final double size;
  final bool showBorder;

  const CustomAvatar({
    super.key,
    this.image,
    this.size = 60,
    this.showBorder = true,
  });
  ImageProvider<Object> getImageProvider() {
    if (image != null) {
      if (image is String && image.isNotEmpty) {
        return NetworkImage(image);
      } else if (image is File) {
        return FileImage(image);
      } else if (image is AssetImage) {
        return image;
      }
    }
    return AssetImage(Assets.images.avatarNull.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient:
            showBorder
                ? const LinearGradient(
                  colors: [AppColor.primary, AppColor.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
      ),
      padding: showBorder ? const EdgeInsets.all(2) : EdgeInsets.zero,
      child: ClipOval(
        child: Container(
          color: AppColor.background,
          child: Image(
            image: getImageProvider(),
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
