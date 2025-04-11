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
      size: context.getWidth * 0.45,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.circle,
        color: Colors.black,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.circle,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Hồ sơ cá nhân",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColor.background,
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            width: context.getWidth,
            padding: EdgeInsets.symmetric(
              horizontal: context.getWidth * 0.05,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primary, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        _settingViewModel.user.value.avatar != null
                            ? NetworkImage(_settingViewModel.user.value.avatar!)
                            : AssetImage(Assets.images.avatarNull.path)
                                as ImageProvider,
                  ),
                ),
                const SizedBox(height: 16),
                // Tên và email
                Text(
                  _settingViewModel.user.value.name ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _settingViewModel.user.value.email ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _userId ?? 'No ID',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                // QR Code
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: qrImageView,
                ),
                const SizedBox(height: 24),
                // Nút quét QR
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.SCANQR),
                  icon: const Icon(Icons.qr_code_scanner, size: 20),
                  label: const Text("Quét mã QR"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
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
