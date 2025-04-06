import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/setting/viewmodels/setting_view_model.dart';
import 'package:momentsy/app/features/setting/views/widgets/setting_item.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/widgets/dialog/custom_dialog.dart';
import 'package:momentsy/gen/assets.gen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final _settingViewModel = Get.find<SettingViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('Cài đặt'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(space12),
        child: Column(
          children: [
            // Profile Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: _buildUserProfile(),
              ),
            ),
            SizedBox(height: 20),
            // Settings Cards
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SettingItem(
                    title: 'Đổi mật khẩu',
                    icon: Icons.lock_outline,
                    iconColor: AppColor.primary,
                    onTap: () {
                      // Get.toNamed('/change-password');
                    },
                  ),
                  Divider(height: 1, indent: 70),
                  SettingItem(
                    title: 'Mã QR',
                    icon: Icons.qr_code_scanner_outlined,
                    iconColor: AppColor.info,
                    onTap: () {
                      Get.toNamed(AppRoutes.PROFILE);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Logout Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: AppColor.surface,
              child: SettingItem(
                title: 'Đăng xuất',
                icon: Icons.logout_outlined,
                iconColor: AppColor.error,
                isLogout: true,
                onTap:
                    () => showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          title: 'Đăng xuất',
                          content: 'Bạn có chắc chắn muốn đăng xuất không?',
                          onConfirm: () => _settingViewModel.logOut(),
                        );
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Obx(
      () => GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.PROFILE),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  _settingViewModel.user.value.avatar != null
                      ? NetworkImage(_settingViewModel.user.value.avatar!)
                      : AssetImage(Assets.images.avatarNull.path),
              radius: 30,
              backgroundColor: AppColor.primaryLight,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _settingViewModel.user.value.name ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  Text(
                    _settingViewModel.user.value.email ?? 'Unknown',
                    style: TextStyle(color: AppColor.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.grey),
          ],
        ),
      ),
    );
  }
}
