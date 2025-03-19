import 'package:flutter/material.dart';
import 'package:momentsy/app/features/home/views/home_screen.dart';
import 'package:momentsy/app/features/notification/views/notification_screen.dart';
import 'package:momentsy/app/features/setting/views/setting_screen.dart';
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
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: index,
        children: [
          HomeScreen(),
          Container(color: Colors.black),
          NotificationScreen(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        backgroundColor: Colors.black,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
