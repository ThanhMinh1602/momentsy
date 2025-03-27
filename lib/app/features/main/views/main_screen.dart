import 'package:flutter/material.dart';
import 'package:momentsy/app/features/home/views/home_screen.dart';
import 'package:momentsy/app/features/notification/views/notification_screen.dart';
import 'package:momentsy/app/features/setting/views/setting_screen.dart';
import 'package:momentsy/app/features/chat/views/chat_screen.dart';
import 'package:momentsy/core/constants/app_color.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: IndexedStack(
        index: index,
        children: [
          HomeScreen(),
          ChatScreen(),
          NotificationScreen(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: AppColor.primaryLight.withOpacity(0.1),
          highlightColor: AppColor.primaryLight.withOpacity(0.1),
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (int i) {
            setState(() {
              index = i;
            });
          },
          backgroundColor: AppColor.surface,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.grey,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined),
              activeIcon: Icon(Icons.notifications),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
