import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/camera/viewmodels/camera_view_model.dart';
import 'package:momentsy/app/features/camera/views/widgets/camera_controller.dart';
import 'package:momentsy/core/constants/app_color.dart';

class CameraViewWidget extends StatelessWidget {
  const CameraViewWidget({super.key, required this.appCameraController});
  final CameraViewModel appCameraController;

  @override
  Widget build(BuildContext context) {
    double baseZoom = 1.0;

    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < -1000) {
                  Get.back();
                }
              },
              onScaleStart:
                  (details) => baseZoom = appCameraController.zoomLevel.value,
              onScaleUpdate:
                  (details) =>
                      appCameraController.updateZoom(baseZoom * details.scale),
              onTapUp:
                  (details) => appCameraController.focusOnPoint(
                    details,
                    MediaQuery.of(context).size,
                  ),
              onDoubleTap: appCameraController.switchCamera,
              child: CameraPreview(appCameraController.cameraController.value!),
            ),
            Obx(() {
              final focusPoint = appCameraController.focusPoint.value;
              return focusPoint != null
                  ? Positioned(
                    left: focusPoint.dx - 20,
                    top: focusPoint.dy - 20,
                    child: Icon(
                      Icons.center_focus_weak_outlined,
                      color: Colors.yellow,
                      size: 40,
                    ),
                  )
                  : SizedBox.shrink();
            }),
            Row(
              children: [
                IconButton(
                  onPressed: appCameraController.switchCamera,
                  icon: Icon(Icons.flash_on, color: AppColor.white),
                ),
                Spacer(),
                IconButton(
                  onPressed: Get.back,
                  icon: Icon(Icons.navigate_next_sharp, color: AppColor.white),
                ),
              ],
            ),
            Positioned(
              bottom: 10.0,
              left: 0,
              right: 0,
              child: Slider(
                value: appCameraController.zoomLevel.value,
                min: appCameraController.minZoom.value,
                max: appCameraController.maxZoom.value,
                onChanged: appCameraController.updateZoom,
              ),
            ),
          ],
        ),
        CameraControllerWidget(appCameraController: appCameraController),
      ],
    );
  }
}
