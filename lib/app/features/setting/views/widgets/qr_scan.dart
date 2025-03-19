import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quét mã QR")),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Obx(() {
            // final result = _friendController.qrResult.value;
            if (true) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Kết quả: ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            // return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    double scanArea = MediaQuery.of(context).size.width * 0.6;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: AppColor.primary,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      // if (scanData.code != null && !_friendController.isProcessing.value) {
      //   _friendController.isProcessing.value = true;
      //   controller.pauseCamera();
      //   _friendController.qrResult.value = scanData.code!;

      //   await _friendController.sendFriendRequest(scanData.code!);

      //   Future.delayed(const Duration(seconds: 2), () {
      //     _friendController.isProcessing.value = false;
      //   });
      // }
    });
  }

  void _onPermissionSet(BuildContext context, bool permissionGranted) {
    log('🎥 Quyền truy cập camera: $permissionGranted');
    if (!permissionGranted) {
      Get.snackbar('Lỗi', 'Không có quyền truy cập camera');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
