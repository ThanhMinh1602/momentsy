import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/services/remote/file_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';

class CameraViewModel extends GetxController {
  CameraViewModel({required FileService fileService})
    : _fileService = fileService;

  final FileService _fileService;

  final Rxn<CameraController> cameraController = Rxn<CameraController>();
  List<CameraDescription>? cameras;

  Rx<int> selectedCameraIndex = 0.obs;
  Rx<bool> isCameraInitialized = false.obs;
  Rx<Offset?> focusPoint = Rx<Offset?>(null);
  Rx<double> zoomLevel = 1.0.obs;
  Rx<double> minZoom = 1.0.obs;
  Rx<double> maxZoom = 1.0.obs;
  RxString imagePath = ''.obs;
  Rx<bool> isLoading = false.obs;

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
    cameras = await availableCameras();
    if (cameras?.isNotEmpty ?? false) {
      await updateCameraIndex(selectedCameraIndex.value);
    }
  }

  /// Update camera based on the selected index
  Future<void> updateCameraIndex(int index) async {
    if (cameras == null || cameras!.isEmpty) return;

    try {
      var newController = CameraController(
        cameras![index],
        ResolutionPreset.ultraHigh,
        enableAudio: false,
      );
      await newController.initialize();

      cameraController.value = newController;
      minZoom.value = await newController.getMinZoomLevel();
      maxZoom.value = await newController.getMaxZoomLevel();
      isCameraInitialized.value = true;
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  /// Switch between available cameras
  void switchCamera() async {
    if (cameras == null || cameras!.isEmpty) return;

    int newIndex = (selectedCameraIndex.value + 1) % cameras!.length;
    await cameraController.value?.dispose();
    cameraController.value = null;
    isCameraInitialized.value = false;

    selectedCameraIndex.value = newIndex;
    await updateCameraIndex(newIndex);
  }

  /// Toggle camera flash mode
  void toggleFlash() {
    cameraController.value?.setFlashMode(FlashMode.auto);
  }

  /// Capture an image and store its path
  Future<void> captureImage() async {
    if (cameraController.value == null) return;

    try {
      final image = await cameraController.value!.takePicture();
      imagePath.value = image.path;
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  /// Upload captured image to server
  Future<void> sendFile() async {
    if (imagePath.value.isEmpty) return;

    isLoading.value = true;
    final result = await _fileService.fileUpload(File(imagePath.value));
    isLoading.value = false;

    result.fold((l) => Get.snackbar('Error', l.message), (r) {
      imagePath.value = '';
      Get.snackbar('Success', r);
      Get.offAllNamed(AppRoutes.MAIN);
    });
  }

  /// Adjust zoom level within the allowed range
  void updateZoom(double newZoom) async {
    double clampedZoom = newZoom.clamp(minZoom.value, maxZoom.value);
    if ((clampedZoom - zoomLevel.value).abs() > 0.1) {
      zoomLevel.value = clampedZoom;
      await cameraController.value?.setZoomLevel(zoomLevel.value);
    }
  }

  /// Focus camera on a specific point
  void focusOnPoint(TapUpDetails details, Size screenSize) {
    if (cameraController.value == null) return;

    final x = details.localPosition.dx / screenSize.width;
    final y = details.localPosition.dy / screenSize.height;

    cameraController.value!.setFocusPoint(Offset(x, y));
    focusPoint.value = details.localPosition;

    Future.delayed(Duration(seconds: 1), () => focusPoint.value = null);
  }
}
