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
              // Camera Preview
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Obx(
                  () => Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(
                      !appCameraController.isRearCamera.value ? 3.14159 : 0,
                    ),
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! < -1000) {
                          Get.back();
                        }
                      },
                      onScaleStart:
                          (details) =>
                              baseZoom = appCameraController.zoomLevel.value,
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
                      child: CameraPreview(
                        appCameraController.cameraController.value!,
                      ),
                    ),
                  ),
                ),
              ),

              // Focus Point Indicator
              Obx(() {
                final focusPoint = appCameraController.focusPoint.value;
                return focusPoint != null
                    ? Positioned(
                      left: focusPoint.dx - 25,
                      top: focusPoint.dy - 25,
                      child: AnimatedOpacity(
                        opacity:
                            appCameraController.isFocusing.value ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.primary,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.center_focus_strong,
                            color: AppColor.primary,
                            size: 24,
                          ),
                        ),
                      ),
                    )
                    : SizedBox.shrink();
              }),

              // Top Controls
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Flash Controls
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Obx(
                          () => IconButton(
                            onPressed: appCameraController.toggleFlash,
                            icon: Icon(
                              appCameraController.flashMode.value ==
                                      FlashMode.off
                                  ? Icons.flash_off
                                  : (appCameraController.flashMode.value ==
                                          FlashMode.always
                                      ? Icons.flash_on
                                      : Icons.flash_auto),
                              color: Colors.white,
                              size: 24,
                            ),
                            tooltip: 'Flash Mode',
                          ),
                        ),
                      ),

                      // Close Camera Button
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: Get.back,
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                          tooltip: 'Close Camera',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Zoom Slider
              Positioned(
                bottom: 24.0,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Icon(Icons.zoom_out, color: Colors.white),
                    Expanded(
                      child: Obx(
                        () => SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 3,
                            activeTrackColor: AppColor.primary,
                            inactiveTrackColor: Colors.white.withOpacity(0.3),
                            thumbColor: AppColor.accent,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 8,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 16,
                            ),
                            overlayColor: AppColor.primary.withOpacity(0.2),
                          ),
                          child: Slider(
                            value: appCameraController.zoomLevel.value,
                            min: appCameraController.minZoom.value,
                            max: appCameraController.maxZoom.value,
                            onChanged: appCameraController.updateZoom,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.zoom_in, color: Colors.white),
                  ],
                ),
              ),

              // Camera Switch Button
              Positioned(
                bottom: 80.0,
                right: 20,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    onTap: appCameraController.switchCamera,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => Icon(
                            appCameraController.isRearCamera.value
                                ? Icons.camera_rear
                                : Icons.camera_front,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Đổi camera',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Zoom Level Indicator
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: Obx(
                    () => AnimatedOpacity(
                      opacity:
                          appCameraController.zoomLevel.value > 1.1 ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${appCameraController.zoomLevel.value.toStringAsFixed(1)}x',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
