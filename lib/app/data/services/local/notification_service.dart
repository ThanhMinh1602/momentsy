import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    print("🔧 Khởi tạo thông báo...");

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    bool? initialized = await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        print("🔔 Người dùng đã nhấn vào thông báo!");
      },
    );

    if (initialized != null && initialized) {
      print("✅ Khởi tạo thành công!");
    } else {
      print("❌ Khởi tạo thất bại!");
    }
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'momentsy', // ID của channel (phải khớp với AndroidManifest.xml)
      'Thông báo chung', // Tên channel
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true, // Bật rung
      vibrationPattern: Int64List.fromList([
        0,
        500,
        1000,
        500,
      ]), // Pattern rung (tắt, 500ms, tắt 1000ms, rung 500ms)
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(id, title, body, platformDetails);
  }

  static Future<void> requestPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }
}
