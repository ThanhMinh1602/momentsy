import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:momentsy/app/data/models/image_model.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/gen/assets.gen.dart';
import 'package:timeago/timeago.dart' as timeago;

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({super.key, this.story});

  final ImageModel? story;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius10),
      child: Stack(children: [_buildImage(), _buildImageNotifi()]),
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
                story?.uploadedBy.avatar != null
                    ? NetworkImage(story!.uploadedBy.avatar!)
                    : AssetImage(Assets.images.avatarNull.path),
            radius: 22,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                story?.uploadedBy.name ?? 'Unknown',
                maxLines: 1,
                style: AppStyle.bold16.copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
              Text(
                timeago.format(
                  story?.uploadedAt ?? DateTime.now(),
                  locale: "vi",
                ),
                style: AppStyle.regular12.copyWith(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return story?.downloadLink == null
        ? Image.asset(Assets.images.imageNull.path)
        : CachedNetworkImage(
          imageUrl: story!.downloadLink,
          fit: BoxFit.scaleDown,
          placeholder:
              (context, url) =>
                  const Center(child: CircularProgressIndicator()),
          errorWidget:
              (context, url, error) => const Icon(Icons.error, size: 50),
        );
  }
}
