import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/features/setting/viewmodels/setting_view_model.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:momentsy/gen/assets.gen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final _settingViewModel = Get.find<SettingViewModel>();
  final _userId = SharedPreferencesService.getUserId();
  @override
  Widget build(BuildContext context) {
    final qrImageView = QrImageView(
      data: _userId ?? '',
      size: context.getWidth * 0.5,
      eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: AppColor.black),
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: AppColor.textPrimary,
      ),
      backgroundColor: Colors.white,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Hồ sơ cá nhân"), centerTitle: true),
      backgroundColor: AppColor.background,
      body: Obx(
        () => Container(
          width: context.getWidth,
          height: context.getHeight,
          padding: EdgeInsets.all(context.getWidth * 0.05),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(_userId ?? ''),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primary, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadow,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        _settingViewModel.user.value.avatar != null
                            ? NetworkImage(_settingViewModel.user.value.avatar!)
                            : AssetImage(Assets.images.avatarNull.path),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  _settingViewModel.user.value.name ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                  ),
                ),
                Text(
                  _settingViewModel.user.value.email ?? 'Unknown',
                  style: TextStyle(fontSize: 16, color: AppColor.textSecondary),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadow,
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: qrImageView,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.SCANQR),
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text("Quét mã QR"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
