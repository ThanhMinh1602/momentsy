import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/camera/viewmodels/camera_view_model.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/widgets/progess/custom_circular_progress.dart';
import 'package:momentsy/gen/assets.gen.dart';

class CameraControllerWidget extends StatelessWidget {
  const CameraControllerWidget({
    super.key,
    required this.appCameraController,
    this.isEdit = false,
  });

  final bool isEdit;
  final CameraViewModel appCameraController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColor.black,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: isEdit ? _buildSendPictureButton() : _buildCameraController(),
      ),
    );
  }

  Widget _buildCameraController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 48.0),
        _buildTakePictureButton(),
        _buildSwitchCameraButton(),
      ],
    );
  }

  Widget _buildSwitchCameraButton() {
    return IconButton(
      onPressed: appCameraController.switchCamera,
      icon: const Icon(
        Icons.cameraswitch_outlined,
        color: AppColor.white,
        size: 24.0,
      ),
    );
  }

  Widget _buildTakePictureButton() {
    return _buildCircleButton(
      onTap: appCameraController.captureImage,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildSendPictureButton() {
    return _buildCircleButton(
      onTap: appCameraController.sendFile,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            color: AppColor.white,
            shape: BoxShape.circle,
          ),
          child:
              appCameraController.isLoading.value
                  ? CustomCircularProgress()
                  : SvgPicture.asset(Assets.icons.send, color: AppColor.black),
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.white, width: 3.0),
        ),
        child: child,
      ),
    );
  }
}
