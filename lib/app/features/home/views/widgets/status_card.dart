import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:momentsy/app/data/models/image_model.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/widgets/card/custom_avatar.dart';
import 'package:momentsy/gen/assets.gen.dart';
import 'package:timeago/timeago.dart' as timeago;

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({super.key, this.story, required this.isFocus});

  final ImageModel? story;
  final bool isFocus;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(),
        child: Stack(children: [_buildImage(), _buildImageNotifi()]),
      ),
    );
  }

  Widget _buildImageNotifi() {
    return Positioned(
      top: space12,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 400),
          scale: isFocus ? 0 : 1.2,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: space6,
              vertical: space4,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAvatar(),
                const SizedBox(width: 5),
                _buildUserInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CustomAvatar(
      imageUrl: story?.uploadedBy?.avatar,
      size: 30,
      showBorder: true,
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          story?.uploadedBy?.name ?? 'Unknown',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyle.bold12.copyWith(color: AppColor.white),
        ),
        const SizedBox(height: 2),
        Text(
          timeago.format(story?.uploadedAt ?? DateTime.now(), locale: "vi"),
          style: TextStyle(
            fontSize: 8,
            color: AppColor.white.withOpacity(0.6),
            fontWeight: FontWeight.w400,
            height: 1.0,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.cardLight,
      ),
      child:
          story?.downloadLink == null
              ? Image.asset(Assets.images.imageNull.path, fit: BoxFit.cover)
              : CachedNetworkImage(
                imageUrl: story!.downloadLink!,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primary,
                        strokeWidth: 2,
                      ),
                    ),
                errorWidget:
                    (context, url, error) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 40,
                            color: AppColor.error,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Không thể tải ảnh',
                            style: TextStyle(
                              color: AppColor.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
    );
  }
}
