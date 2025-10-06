import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/services/remote/file_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:image/image.dart' as img;
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class CameraViewModel extends BaseViewModel {
  CameraViewModel({required FileService fileService})
    : _fileService = fileService;

  final FileService _fileService;

  final Rxn<CameraController> cameraController = Rxn<CameraController>();
  List<CameraDescription>? cameras;

  Rx<int> selectedCameraIndex = 0.obs;
  Rx<bool> isCameraInitialized = false.obs;
  Rx<bool> isFrontCamera = false.obs;
  Rx<Offset?> focusPoint = Rx<Offset?>(null);
  Rx<double> zoomLevel = 1.0.obs;
  Rx<double> minZoom = 1.0.obs;
  Rx<double> maxZoom = 1.0.obs;
  RxString imagePath = ''.obs;

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
      isFrontCamera.value =
          cameras![0].lensDirection == CameraLensDirection.front;
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
      isFrontCamera.value =
          cameras![index].lensDirection == CameraLensDirection.front;
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
      setLoading(true);
      final XFile image = await cameraController.value!.takePicture();

      if (isFrontCamera.value) {
        // Process image in memory
        final Uint8List bytes = await image.readAsBytes();
        final img.Image? imageData = img.decodeImage(bytes);
        if (imageData != null) {
          final img.Image flippedImage = img.flipHorizontal(imageData);
          final Uint8List flippedBytes = Uint8List.fromList(
            img.encodeJpg(flippedImage, quality: 95),
          );

          // Write the processed image directly
          await File(image.path).writeAsBytes(flippedBytes);
        }
      } else {
        // for back camera, ensure the image is in JPG format
        final Uint8List bytes = await image.readAsBytes();
        final img.Image? imageData = img.decodeImage(bytes);
        if (imageData != null) {
          final Uint8List jpgBytes = Uint8List.fromList(
            img.encodeJpg(imageData, quality: 95),
          );
          await File(image.path).writeAsBytes(jpgBytes);
        }
      }
      setLoading(false);
      imagePath.value = image.path;
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  /// Upload captured image to server
  Future<void> sendFile() async {
    if (imagePath.value.isEmpty) return;

    setLoading(true);
    final result = await _fileService.fileUpload(File(imagePath.value));
    setLoading(false);

    result.fold((l) => Get.snackbar('Error', l.message), (r) {
      imagePath.value = '';
      Get.snackbar('Success', r.message);
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
