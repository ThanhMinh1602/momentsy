import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/models/image_model.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/file_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';
import 'package:momentsy/gen/assets.gen.dart';

class HomeViewModel extends BaseViewModel {
  final FileService _fileService;
  HomeViewModel({required FileService fileService})
    : _fileService = fileService;

  RxList<ImageModel> images = <ImageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    setLoading(true);
    final result = await _fileService.getAllFile(
      SharedPreferencesService.getUserId() ?? '',
    );
    setLoading(false);

    result.fold((l) => showError(l.message), (r) {
      images.value = r.data ?? [];
      for (var img in r.data ?? []) {
        precacheImage(
          img.viewLink == null
              ? AssetImage(Assets.images.imageNull.path)
              : NetworkImage(img.viewLink!),
          Get.context!,
        );
      }
    });
  }
}
