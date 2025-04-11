import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/features/setting/viewmodels/setting_view_model.dart';
import 'package:momentsy/app/features/setting/views/widgets/setting_item.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/widgets/card/custom_avatar.dart';
import 'package:momentsy/core/widgets/dialog/custom_dialog.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final _settingViewModel = Get.find<SettingViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ).copyWith(top: MediaQuery.of(context).padding.top + verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: space16),
            _buildUserProfile(),
            const SizedBox(height: space24),
            _buildSettingList(context),
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
            CustomAvatar(
              imageUrl: _settingViewModel.user.value.avatar,
              size: 60,
              showBorder: true,
            ),
            const SizedBox(width: space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _settingViewModel.user.value.name ?? 'Không rõ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _settingViewModel.user.value.email ?? 'Không rõ',
                    style: const TextStyle(color: AppColor.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingList(BuildContext context) {
    return Column(
      children: [
        SettingItem(
          title: 'Đổi mật khẩu',
          icon: Icons.lock_outline,
          iconColor: AppColor.primary,
          onTap: () {
            // Get.toNamed('/change-password');
          },
        ),
        const Divider(height: 1, indent: 52),
        SettingItem(
          title: 'Mã QR',
          icon: Icons.qr_code_scanner_outlined,
          iconColor: AppColor.info,
          onTap: () {
            Get.toNamed(AppRoutes.PROFILE);
          },
        ),
        const SizedBox(height: space24),
        SettingItem(
          title: 'Đăng xuất',
          icon: Icons.logout_outlined,
          iconColor: AppColor.error,
          isLogout: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomDialog(
                  title: 'Đăng xuất',
                  content: 'Bạn có chắc chắn muốn đăng xuất không?',
                  onConfirm: () => _settingViewModel.logOut(),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
