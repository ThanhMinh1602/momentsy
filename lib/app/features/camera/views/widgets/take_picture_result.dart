import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/camera/viewmodels/camera_view_model.dart';
import 'package:momentsy/app/features/camera/views/widgets/camera_controller.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/gen/assets.gen.dart';

class TakePictureResult extends GetWidget<CameraViewModel> {
  const TakePictureResult({
    Key? key,
    required this.imagePath,
    required this.onEditingComplete,
  }) : super(key: key);

  final String imagePath;
  final Function(String) onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: _buildImageEditWidget(context),
    );
  }

  Widget _buildImageEditWidget(BuildContext context) {
    final captionController = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image Preview with Mirror effect for front camera
              Hero(
                tag: 'capturedImage',
                child: Obx(
                  () => Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(
                      !controller.isRearCamera.value
                          ? 3.14159
                          : 0, // Mirror if front camera
                    ),
                    child: Image.file(File(imagePath), fit: BoxFit.contain),
                  ),
                ),
              ),

              // Top Controls
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _buildIconButton(
                              icon: Icons.arrow_back,
                              tooltip: 'Back to camera',
                              onTap: () {
                                controller.imagePath.value = '';
                              },
                            ),
                            Spacer(),
                            _buildIconButton(
                              icon: Icons.text_fields,
                              tooltip: 'Add text',
                              onTap: () => _showFeatureInDevelopment(),
                            ),
                            SizedBox(width: 16),
                            _buildIconButton(
                              icon: Icons.music_note,
                              tooltip: 'Add music',
                              onTap: () => _showFeatureInDevelopment(),
                            ),
                            SizedBox(width: 16),
                            _buildIconButton(
                              icon: Icons.brush,
                              tooltip: 'Draw',
                              onTap: () => _showFeatureInDevelopment(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Caption Text Field
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColor.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: captionController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Thêm chú thích...',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.white70,
                        ),
                        onPressed: () => _showFeatureInDevelopment(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        CameraControllerWidget(appCameraController: controller, isEdit: true),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String tooltip,
    VoidCallback? onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color ?? Colors.white, size: 24),
        ),
      ),
    );
  }

  void _showFeatureInDevelopment() {
    Get.snackbar(
      '',
      'Tính năng đang được phát triển',
      backgroundColor: Colors.black54,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      borderRadius: 10,
      duration: Duration(seconds: 2),
    );
  }
}
