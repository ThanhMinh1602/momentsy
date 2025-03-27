import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/app/data/services/local/shared_preferences_service.dart';
import 'package:momentsy/app/routes/app_routes.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/extension/build_context_extension.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String userId = SharedPreferencesService.getUserId() ?? 'Unknown';
    String userName = "Nguyễn Thanh Minh";
    String userEmail = "nt16201@gmail.com";

    final qrImageView = QrImageView(
      data: userId,
      size: context.getWidth * 0.5,
      eyeStyle: QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: AppColor.primary,
      ),
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: AppColor.textPrimary,
      ),
      backgroundColor: Colors.white,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Hồ sơ cá nhân"), centerTitle: true),
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2020/04/11/00/25/handmade-5028252_1280.jpg',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              Text(
                userEmail,
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
    );
  }
}
