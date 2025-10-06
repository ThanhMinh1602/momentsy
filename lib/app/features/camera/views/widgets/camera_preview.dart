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
        Expanded(
          child: Stack(
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
                    (details) => appCameraController.updateZoom(
                      baseZoom * details.scale,
                    ),
                onTapUp:
                    (details) => appCameraController.focusOnPoint(
                      details,
                      MediaQuery.of(context).size,
                    ),
                onDoubleTap: appCameraController.switchCamera,
                child: Obx(() {
                  final isFrontCamera = appCameraController.isFrontCamera.value;
                  return Transform(
                    alignment: Alignment.center,
                    transform:
                        Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(isFrontCamera ? 3.14159 : 0),
                    child: CameraPreview(
                      appCameraController.cameraController.value!,
                    ),
                  );
                }),
              ),
              // Focus point indicator
              Obx(() {
                final focusPoint = appCameraController.focusPoint.value;
                return focusPoint != null
                    ? Positioned(
                      left: focusPoint.dx - 20,
                      top: focusPoint.dy - 20,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.center_focus_weak_outlined,
                          color: Colors.yellow,
                          size: 40,
                        ),
                      ),
                    )
                    : const SizedBox.shrink();
              }),
              // Top controls
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: appCameraController.switchCamera,
                        icon: const Icon(
                          Icons.flip_camera_ios,
                          color: AppColor.white,
                        ),
                        iconSize: 28,
                      ),
                      IconButton(
                        onPressed: Get.back,
                        icon: const Icon(Icons.close, color: AppColor.white),
                        iconSize: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        CameraControllerWidget(appCameraController: appCameraController),
      ],
    );
  }
}
