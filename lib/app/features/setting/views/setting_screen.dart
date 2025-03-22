import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/notification_service.dart';
import 'package:momentsy/app/features/setting/viewmodels/setting_view_model.dart';
import 'package:momentsy/app/features/setting/views/widgets/setting_item.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/widgets/card/custom_app_card.dart';
import 'package:momentsy/core/widgets/dialog/custom_dialog.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final _settingViewModel = Get.find<SettingViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.k1A1C1E,
      body: Padding(
        padding: EdgeInsets.all(
          space12,
        ).copyWith(top: MediaQuery.of(context).padding.top + space12),
        child: CustomAppCard(
          backgroundColor: AppColor.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserProfile(),
              Divider(),
              SettingItem(
                title: 'Đổi mật khẩu',
                icon: Icons.lock,
                onTap: () {
                  // Get.toNamed('/change-password');
                },
              ),
              SettingItem(
                title: 'Qr code',
                icon: Icons.qr_code,
                onTap: () {
                  Get.toNamed(AppRoutes.PROFILE);
                },
              ),
              SettingItem(
                title: 'Đăng xuất',
                icon: Icons.logout,
                isLogout: true,
                onTap:
                    () => showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          title: 'Đăng xuất',
                          content: 'Bạn có chắc chắn muốn đăng xuất không',
                          onConfirm: () => _settingViewModel.logOut(),
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.PROFILE),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2016/08/11/17/46/hoian-1586344_1280.jpg',
            ),
            radius: 30,
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nguyễn Thanh Minh',
                style: AppStyle.bold18.copyWith(color: AppColor.white),
              ),
              Text(
                'ntminh16201@gmail.com',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
