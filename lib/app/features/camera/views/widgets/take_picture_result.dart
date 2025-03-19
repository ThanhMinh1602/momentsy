import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/camera/viewmodels/camera_view_model.dart';
import 'package:momentsy/app/features/camera/views/widgets/camera_controller.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/gen/assets.gen.dart';

// ignore: must_be_immutable
class TakePictureResult extends StatelessWidget {
  const TakePictureResult({super.key, required this.appCameraController});

  final CameraViewModel appCameraController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(() => _buildImageEditWidget()),
    );
  }

  Widget _buildImageEditWidget() {
    return Column(
      children: [
        Stack(
          children: [
            Image.file(File(appCameraController.imagePath.value)),
            Positioned(
              top: 12.0,
              left: 12.0,
              right: 12.0,
              child: Row(
                spacing: space12,
                children: [
                  _buildIconButton(
                    iconPath: Assets.icons.arrowBack,
                    onTap: () {
                      appCameraController.imagePath.value = '';
                    },
                  ),
                  Spacer(),
                  _buildIconButton(
                    iconPath: Assets.icons.textSquare,
                    onTap: () {},
                  ),
                  _buildIconButton(iconPath: Assets.icons.musicNote),
                  _buildIconButton(iconPath: Assets.icons.paintbrush),
                ],
              ),
            ),
          ],
        ),
        CameraControllerWidget(
          appCameraController: appCameraController,
          isEdit: true,
        ),
      ],
    );
  }

  Widget _buildIconButton({void Function()? onTap, required String iconPath}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.k1A1C1E.withOpacity(0.4),
        ),
        child: SvgPicture.asset(iconPath, width: 16, color: AppColor.white),
      ),
    );
  }
}
