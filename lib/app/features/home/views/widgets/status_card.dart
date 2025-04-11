import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:momentsy/app/data/models/image_model.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/gen/assets.gen.dart';
import 'package:timeago/timeago.dart' as timeago;

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({super.key, this.story, required this.isFocus});

  final ImageModel? story;
  final bool isFocus;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [_buildImage(), if (!isFocus) _buildImageNotifi()],
      ),
    );
  }

  Widget _buildImageNotifi() {
    return Positioned(
      left: space12,
      right: space12,
      top: space12,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.white,
            backgroundImage:
                story?.uploadedBy?.avatar != null
                    ? NetworkImage(story!.uploadedBy!.avatar!)
                    : AssetImage(Assets.images.avatarNull.path),
            radius: 22,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                story?.uploadedBy?.name ?? 'Unknown',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(1, 1),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              Text(
                timeago.format(
                  story?.uploadedAt ?? DateTime.now(),
                  locale: "vi",
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(1, 1),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return story?.downloadLink == null
        ? Image.asset(Assets.images.imageNull.path)
        : CachedNetworkImage(
          imageUrl: story!.downloadLink!,
          fit: BoxFit.scaleDown,
          placeholder:
              (context, url) => Center(
                child: CircularProgressIndicator(color: AppColor.primary),
              ),
          errorWidget:
              (context, url, error) => Container(
                color: AppColor.cardLight,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 50, color: AppColor.error),
                      SizedBox(height: 8),
                      Text(
                        'Không thể tải ảnh',
                        style: TextStyle(color: AppColor.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
        );
  }
}
