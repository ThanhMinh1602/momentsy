import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/models/image_model.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/file_service.dart';

class HomeViewModel extends GetxController {
  final FileService _fileService;
  HomeViewModel({required FileService fileService})
    : _fileService = fileService;

  RxList<ImageModel> images = <ImageModel>[].obs;
  Rx<bool> isLoading = false.obs;
  final userId = SharedPreferencesService.getUserId();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    final result = await _fileService.getAllFile(userId!);
    isLoading.value = false;

    result.fold((l) => Get.snackbar('Lỗi', l.message), (r) {
      images.value = r;
      for (var img in r) {
        precacheImage(NetworkImage(img.viewLink), Get.context!);
      }
    });
  }
}
