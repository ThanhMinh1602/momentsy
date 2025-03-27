import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/camera/viewmodels/camera_view_model.dart';
import 'package:momentsy/core/constants/app_color.dart';
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
      height: 120,
      color: Colors.black.withOpacity(0.6),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: isEdit ? _buildSendPictureButton() : _buildCameraController(),
    );
  }

  Widget _buildCameraController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Gallery Access Button
        Obx(
          () => AnimatedOpacity(
            opacity: appCameraController.isFocusing.value ? 0.3 : 1.0,
            duration: Duration(milliseconds: 200),
            child: IconButton(
              onPressed: () {
                // Open gallery functionality would go here
                Get.snackbar(
                  "",
                  "Đang phát triển tính năng này",
                  backgroundColor: Colors.black54,
                  colorText: Colors.white,
                  borderRadius: 10,
                  margin: EdgeInsets.all(10),
                  duration: Duration(seconds: 1),
                );
              },
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.photo_library, color: Colors.white, size: 24),
              ),
            ),
          ),
        ),

        // Take Picture Button
        Obx(
          () => AnimatedScale(
            scale: appCameraController.isFocusing.value ? 0.9 : 1.0,
            duration: Duration(milliseconds: 200),
            child: _buildTakePictureButton(),
          ),
        ),

        // Switch Camera Button
        Obx(
          () => AnimatedOpacity(
            opacity: appCameraController.isFocusing.value ? 0.3 : 1.0,
            duration: Duration(milliseconds: 200),
            child: IconButton(
              onPressed: appCameraController.switchCamera,
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cameraswitch_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTakePictureButton() {
    return GestureDetector(
      onTap: appCameraController.captureImage,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.primary.withOpacity(0.8),
            width: 4.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.primary.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildSendPictureButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Cancel Button
        OutlinedButton.icon(
          onPressed: () => appCameraController.imagePath.value = '',
          icon: Icon(Icons.close),
          label: Text('Hủy'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: Colors.white70, width: 1.5),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        // Share Button
        ElevatedButton.icon(
          onPressed: appCameraController.sendFile,
          icon: Obx(
            () =>
                appCameraController.isLoading.value
                    ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : SvgPicture.asset(
                      Assets.icons.send,
                      color: Colors.white,
                      width: 18,
                      height: 18,
                    ),
          ),
          label: Text(
            appCameraController.isLoading.value ? 'Đang gửi...' : 'Chia sẻ',
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
