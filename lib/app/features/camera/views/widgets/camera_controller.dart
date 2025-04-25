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
    return Container(
      color: AppColor.black,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: isEdit ? _buildSendPictureButton() : _buildCameraController(),
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
    return Obx(
      () => _buildCircleButton(
        onTap:
            appCameraController.isLoading.value
                ? null
                : appCameraController.captureImage,
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            color: AppColor.white,
            shape: BoxShape.circle,
          ),
          child:
              appCameraController.isLoading.value
                  ? CustomCircularProgress()
                  : const SizedBox.shrink(), // hoặc bạn có thể để icon camera nhỏ ở đây nếu thích
        ),
      ),
    );
  }

  Widget _buildSendPictureButton() {
    return Obx(
      () => _buildCircleButton(
        onTap:
            appCameraController.isLoading.value
                ? null
                : appCameraController.sendFile,
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            color: AppColor.white,
            shape: BoxShape.circle,
          ),
          child:
              appCameraController.isLoading.value
                  ? CustomCircularProgress(size: 12)
                  : SvgPicture.asset(Assets.icons.send, color: AppColor.black),
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required VoidCallback? onTap,
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
          border: Border.all(color: AppColor.primary, width: 3.0),
        ),
        child: child,
      ),
    );
  }
}
