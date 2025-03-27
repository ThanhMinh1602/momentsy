import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/services/remote/file_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';

class CameraViewModel extends GetxController {
  CameraViewModel({required FileService fileService})
    : _fileService = fileService;

  final FileService _fileService;

  final Rxn<CameraController> cameraController = Rxn<CameraController>();
  List<CameraDescription>? cameras;

  // Camera state variables
  Rx<int> selectedCameraIndex = 0.obs;
  Rx<bool> isCameraInitialized = false.obs;
  Rx<Offset?> focusPoint = Rx<Offset?>(null);
  Rx<double> zoomLevel = 1.0.obs;
  Rx<double> minZoom = 1.0.obs;
  Rx<double> maxZoom = 1.0.obs;
  Rx<FlashMode> flashMode = FlashMode.auto.obs;
  RxString imagePath = ''.obs;
  Rx<bool> isLoading = false.obs;
  RxBool isFocusing = false.obs;
  RxBool isMirrorMode = false.obs;
  RxBool isRearCamera = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  @override
  void onClose() {
    cameraController.value?.dispose();
    super.onClose();
  }

  /// Initialize available cameras and set the default camera
  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();

      // Sort cameras: rear camera first, front camera second
      if (cameras != null && cameras!.length > 1) {
        cameras!.sort((a, b) {
          // Prioritize rear camera to be first in the list
          if (a.lensDirection == CameraLensDirection.back) return -1;
          if (b.lensDirection == CameraLensDirection.back) return 1;
          return 0;
        });
      }

      if (cameras?.isNotEmpty ?? false) {
        selectedCameraIndex.value = 0; // Start with rear camera if available
        await updateCameraIndex(selectedCameraIndex.value);

        // Log camera info after initialization
        debugCameraInfo();
      } else {
        print("No cameras available on this device!");
      }
    } catch (e) {
      print("Error initializing camera: $e");
      Get.snackbar(
        'Camera Error',
        'Failed to initialize camera: $e',
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Update camera based on the selected index
  Future<void> updateCameraIndex(int index) async {
    if (cameras == null || cameras!.isEmpty) return;

    try {
      var newController = CameraController(
        cameras![index],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await newController.initialize();

      // Apply stored flash mode
      await newController.setFlashMode(flashMode.value);
      cameraController.value = newController;

      // Update zoom levels
      minZoom.value = await newController.getMinZoomLevel();
      maxZoom.value = await newController.getMaxZoomLevel();

      // Update isRearCamera based on lens direction
      isRearCamera.value =
          cameras![index].lensDirection == CameraLensDirection.back;
      // Automatically set mirror mode based on camera direction
      isMirrorMode.value = !isRearCamera.value;

      isCameraInitialized.value = true;
    } catch (e) {
      print("Error initializing camera: $e");
      Get.snackbar(
        'Camera Error',
        'Failed to initialize camera: $e',
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Switch between available cameras
  Future<void> switchCamera() async {
    if (cameras == null || cameras!.isEmpty) {
      print("No cameras available!");
      return;
    }

    if (cameras!.length > 1) {
      try {
        final newIndex = (selectedCameraIndex.value + 1) % cameras!.length;
        print(
          "Switching camera to index $newIndex: ${cameras![newIndex].name}, ${cameras![newIndex].lensDirection}",
        );

        selectedCameraIndex.value = newIndex;
        await updateCameraIndex(newIndex);

        // Log camera info after switch
        debugCameraInfo();

        final snackText =
            isRearCamera.value
                ? 'Đã chuyển sang camera sau'
                : 'Đã chuyển sang camera trước';

        Get.snackbar(
          '',
          snackText,
          backgroundColor: Colors.black54,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20),
          borderRadius: 10,
          duration: Duration(seconds: 1),
        );
      } catch (e) {
        print("Error switching camera: $e");
        Get.snackbar(
          'Camera Error',
          'Failed to switch camera: $e',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        // Try to recover by reinitializing
        await reinitializeCamera();
      }
    } else {
      print("Error: No secondary camera available");
      Get.snackbar(
        'Camera Error',
        'No additional camera available',
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Toggle through camera flash modes
  void toggleFlash() async {
    if (cameraController.value == null) return;

    switch (flashMode.value) {
      case FlashMode.off:
        flashMode.value = FlashMode.auto;
        break;
      case FlashMode.auto:
        flashMode.value = FlashMode.always;
        break;
      case FlashMode.always:
      case FlashMode.torch:
        flashMode.value = FlashMode.off;
        break;
    }

    await cameraController.value!.setFlashMode(flashMode.value);

    // Show feedback to user
    String flashText = '';
    switch (flashMode.value) {
      case FlashMode.off:
        flashText = 'Flash: Off';
        break;
      case FlashMode.auto:
        flashText = 'Flash: Auto';
        break;
      case FlashMode.always:
        flashText = 'Flash: On';
        break;
      case FlashMode.torch:
        flashText = 'Flash: Torch';
        break;
    }

    Get.snackbar(
      '',
      flashText,
      backgroundColor: Colors.black54,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(top: 80, left: 80, right: 80),
      borderRadius: 20,
      duration: Duration(milliseconds: 800),
      isDismissible: true,
      maxWidth: 160,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  /// Capture an image and store its path
  Future<void> captureImage() async {
    if (cameraController.value == null) return;

    try {
      // Play camera shutter animation
      // Temporarily disable UI for the capture moment
      isFocusing.value = true;

      // Take picture
      final image = await cameraController.value!.takePicture();
      imagePath.value = image.path;

      // Re-enable UI
      isFocusing.value = false;
    } catch (e) {
      print("Error capturing image: $e");
      Get.snackbar(
        'Error',
        'Failed to capture image',
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Upload captured image to server
  Future<void> sendFile() async {
    if (imagePath.value.isEmpty) return;

    isLoading.value = true;
    final result = await _fileService.fileUpload(File(imagePath.value));
    isLoading.value = false;

    result.fold(
      (l) => Get.snackbar(
        'Lỗi',
        l.message,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      ),
      (r) {
        imagePath.value = '';
        Get.snackbar(
          'Thành công',
          'Ảnh đã được đăng lên',
          backgroundColor: AppColor.primary.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(AppRoutes.MAIN);
      },
    );
  }

  /// Adjust zoom level within the allowed range
  void updateZoom(double newZoom) async {
    if (cameraController.value == null) return;

    double clampedZoom = newZoom.clamp(minZoom.value, maxZoom.value);
    if ((clampedZoom - zoomLevel.value).abs() > 0.05) {
      zoomLevel.value = clampedZoom;
      await cameraController.value?.setZoomLevel(zoomLevel.value);
    }
  }

  /// Focus camera on a specific point
  void focusOnPoint(TapUpDetails details, Size screenSize) {
    if (cameraController.value == null) return;

    final x = details.localPosition.dx / screenSize.width;
    final y = details.localPosition.dy / screenSize.height;

    // Start focusing animation
    isFocusing.value = true;
    focusPoint.value = details.localPosition;

    // Set focus point on camera
    cameraController.value!.setFocusPoint(Offset(x, y));
    cameraController.value!.setExposurePoint(Offset(x, y));

    // End focusing animation after delay
    Future.delayed(Duration(milliseconds: 800), () {
      isFocusing.value = false;
      Future.delayed(Duration(milliseconds: 200), () {
        focusPoint.value = null;
      });
    });
  }

  /// Check and debug camera information
  void debugCameraInfo() {
    if (cameras == null || cameras!.isEmpty) {
      print("No cameras available!");
      return;
    }

    print("\n=== CAMERA DEBUG INFO ===");
    print("Total cameras available: ${cameras!.length}");
    cameras!.asMap().forEach((index, camera) {
      final isCurrent = index == selectedCameraIndex.value;
      print("Camera $index${isCurrent ? ' (CURRENT)' : ''}: ${camera.name}");
      print("  - Lens Direction: ${camera.lensDirection}");
      print("  - Sensor Orientation: ${camera.sensorOrientation}°");
    });
    print("Current camera index: ${selectedCameraIndex.value}");
    print("isRearCamera: ${isRearCamera.value}");
    print("isMirrorMode: ${isMirrorMode.value}");
    print("=== END CAMERA DEBUG ===\n");
  }

  /// Initialize cameras with a fresh detection
  Future<void> reinitializeCamera() async {
    // Release current camera
    if (cameraController.value != null) {
      await cameraController.value!.dispose();
      cameraController.value = null;
    }

    // Re-scan available cameras
    cameras = await availableCameras();
    debugCameraInfo();

    // Reset to first camera
    if (cameras?.isNotEmpty ?? false) {
      selectedCameraIndex.value = 0;
      await updateCameraIndex(selectedCameraIndex.value);
    }
  }
}
