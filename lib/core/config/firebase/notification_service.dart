import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  String? _deviceToken;

  Future<void> initFirebase() async {
    _requestPermission();
    await _setupLocalNotifications();
    _getToken();
    _setupForegroundNotifications();
  }

  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(settings);
  }

  /// Lấy Token FCM và gửi lên Server
  Future<void> _getToken() async {
    _deviceToken = await _firebaseMessaging.getToken();
  }

  String? getDeviceToken() => _deviceToken;

  /// Yêu cầu quyền nhận thông báo
  void _requestPermission() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print("🚫 Quyền thông báo bị từ chối!");
    }
  }

  /// Lắng nghe thông báo khi app mở
  void _setupForegroundNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("📩 Nhận thông báo khi app mở: ${message.notification?.title}");

        // Hiển thị thông báo trên UI
        _showNotification(
          message.notification?.title,
          message.notification?.body,
        );
      }
    });
  }

  /// Cấu hình và hiển thị thông báo khi app mở
  Future<void> _showNotification(String? title, String? body) async {
    var androidDetails = const AndroidNotificationDetails(
      'momentsy', // 👈 Đặt ID phù hợp
      'Thông báo quan trọng',
      channelDescription: 'Kênh này dùng để nhận thông báo quan trọng.',
      importance: Importance.max,
      priority: Priority.high,
    );

    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(0, title, body, generalNotificationDetails);
  }

  /// Xử lý khi người dùng nhấn vào thông báo
  void onNotificationTap(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🔔 Người dùng nhấn vào thông báo: ${message.notification?.title}");

      // TODO: Xử lý điều hướng khi nhấn vào thông báo
      // Navigator.push(context, MaterialPageRoute(builder: (context) => SomeScreen()));
    });
  }
}
