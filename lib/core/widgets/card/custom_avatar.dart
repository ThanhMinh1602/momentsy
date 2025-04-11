import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/gen/assets.gen.dart';

class CustomAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showBorder;
  final bool isAsset;

  const CustomAvatar({
    super.key,
    this.imageUrl,
    this.size = 60,
    this.showBorder = true,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object> avatarImage =
        imageUrl != null && imageUrl!.isNotEmpty
            ? isAsset
                ? AssetImage(imageUrl!)
                : NetworkImage(imageUrl!)
            : AssetImage(Assets.images.avatarNull.path);
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
            image: avatarImage,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
