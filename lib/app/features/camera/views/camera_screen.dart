import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/camera/viewmodels/camera_view_model.dart';
import 'package:momentsy/app/features/camera/views/widgets/camera_preview.dart';
import 'package:momentsy/app/features/camera/views/widgets/take_picture_result.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _appCameraController = Get.find<CameraViewModel>();

    return WillPopScope(
      onWillPop: () async {
        if (_appCameraController.imagePath.isNotEmpty) {
          _appCameraController.imagePath.value = '';
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.black,
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          if (!_appCameraController.isCameraInitialized.value) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            width: context.getWidth,
            height: context.getHeight,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child:
                _appCameraController.imagePath.value.isNotEmpty
                    ? TakePictureResult(
                      appCameraController: _appCameraController,
                    )
                    : CameraViewWidget(
                      appCameraController: _appCameraController,
                    ),
          );
        }),
      ),
    );
  }
}
