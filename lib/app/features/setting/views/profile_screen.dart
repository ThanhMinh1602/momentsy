import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/setting/viewmodels/setting_view_model.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:momentsy/core/widgets/card/custom_avatar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final SettingViewModel _settingViewModel = Get.find<SettingViewModel>();
  initState() {
    super.initState();
    _nameController.text = _settingViewModel.user.value.name ?? '';
    _emailController.text = _settingViewModel.user.value.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final qrImageView = QrImageView(
      data: _settingViewModel.userId,
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
                GestureDetector(
                  onTap: () async {
                    await _settingViewModel.avaterPicker();
                  },
                  child: CustomAvatar(
                    image:
                        _settingViewModel.avatarFile.value != null
                            ? _settingViewModel.avatarFile.value
                            : _settingViewModel.user.value.avatar,
                    size: context.getWidth * 0.25,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Tên",
                    labelStyle: TextStyle(color: AppColor.textPrimary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: AppColor.surface,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: AppColor.textPrimary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: AppColor.surface,
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
                const SizedBox(height: 24),
                // Nút lưu thông tin sau khi chỉnh sửa
                ElevatedButton(
                  onPressed: () {
                    _settingViewModel.updateUserProfile(
                      _nameController.text,
                      _emailController.text,
                      null,
                    );

                    Get.snackbar('Thông báo', 'Cập nhật hồ sơ thành công');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Lưu thay đổi"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
