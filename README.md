# Momentsy

Momentsy là ứng dụng mạng xã hội mobile cho phép người dùng chia sẻ khoảnh khắc trong cuộc sống hàng ngày.

## Tính năng chính

- **Chia sẻ khoảnh khắc**: Đăng tải hình ảnh và video ngắn về những khoảnh khắc trong cuộc sống
- **Tương tác**: Like, comment và chia sẻ nội dung với bạn bè
- **Nhắn tin**: Trò chuyện trực tiếp với bạn bè thông qua tính năng chat
- **Thông báo**: Cập nhật thông báo khi có tương tác mới
- **Tùy chỉnh cá nhân**: Quản lý tài khoản và cài đặt ứng dụng

## Công nghệ sử dụng

- **Framework**: Flutter
- **State Management**: GetX
- **Backend**: Firebase
- **Authentication**: Firebase Auth với nhiều phương thức đăng nhập (Email, Google, Facebook, Apple)
- **Realtime Database**: Firebase Realtime Database/Firestore
- **Notifications**: Firebase Cloud Messaging

## Yêu cầu hệ thống

- Flutter 3.0.0 trở lên
- Dart 2.17.0 trở lên
- Android SDK 21+ hoặc iOS 11+

## Cài đặt

1. Clone repository:
```bash
git clone https://github.com/yourusername/momentsy.git
```

2. Cài đặt dependencies:
```bash
flutter pub get
```

3. Tạo file .env trong thư mục gốc và thêm các biến môi trường cần thiết:
```
API_KEY=your_api_key
APP_ID=your_app_id
```

4. Chạy ứng dụng:
```bash
flutter run
```

## Cấu trúc dự án

```
lib/
├── app/                  # App-specific code
│   ├── bindings/         # Dependency injection
│   ├── data/             # Data layer (models, repositories)
│   ├── features/         # UI features
│   │   ├── auth/         # Authentication screens
│   │   ├── home/         # Home feed
│   │   ├── chat/         # Messaging
│   │   ├── notification/ # Notification screens
│   │   └── setting/      # App settings
│   └── routes/           # App navigation
├── core/                 # Core functionality
│   ├── config/           # App configuration
│   ├── constants/        # App constants
│   ├── enum/             # Enumerations
│   ├── exception/        # Custom exceptions
│   ├── extension/        # Extension methods
│   ├── utils/            # Utility functions
│   └── widgets/          # Reusable widgets
├── gen/                  # Generated files
└── main.dart             # Entry point
```

## Giao diện

Momentsy có giao diện tối với các điểm nhấn màu sắc, tạo trải nghiệm người dùng hiện đại và thân thiện. Ứng dụng được thiết kế để dễ sử dụng với một tay, với điều hướng trực quan và hiệu ứng mượt mà.

## Đóng góp

Nếu bạn muốn đóng góp cho dự án, vui lòng tạo pull request hoặc báo cáo issues trên GitHub.
