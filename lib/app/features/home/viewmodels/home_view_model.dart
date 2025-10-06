import 'package:get/get.dart';
import 'package:momentsy/app/data/models/image_model.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/data/services/remote/file_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

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

  result.fold((l) => showError(l.message), (r) async {
    images.value = r.data ?? [];
    // await Future.wait((r.data ?? []).map((img) async {
    //   await precacheImage(
    //     img.viewLink == null
    //         ? AssetImage(Assets.images.imageNull.path)
    //         : NetworkImage(img.viewLink!) as ImageProvider,
    //     Get.context!,
    //   );
    // }));
  });
}

}
