import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_style.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String userId = SharedPreferencesService.getUserId() ?? 'Unknown';
    String userName = "Nguyễn Thanh Minh";
    String userEmail = "nt16201@gmail.com";

    final qrImageView = QrImageView(data: userId, size: context.getWidth * 0.4);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        title: Text("Hồ sơ cá nhân", style: AppStyle.bold16),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColor.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.k1A1C1E,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2020/04/11/00/25/handmade-5028252_1280.jpg',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: AppStyle.bold18.copyWith(color: AppColor.white),
              ),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(color: AppColor.kEFF0F6, child: qrImageView),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.SCANQR),
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("Quét mã QR"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
