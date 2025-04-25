import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentsy/app/features/home/views/home_screen.dart';
import 'package:momentsy/app/features/notification/views/notification_screen.dart';
import 'package:momentsy/app/features/setting/views/setting_screen.dart';
import 'package:momentsy/app/features/chat/views/chat_screen.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';
import 'package:momentsy/core/widgets/tabbar/custom_tab_bar.dart';
import 'package:momentsy/gen/assets.gen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final List<Widget> _bottomNav = [
   FaIcon(FontAwesomeIcons.smile),
    FaIcon(Icons.chat),
    FaIcon(Icons.notifications),
    FaIcon(Icons.settings),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            ChatScreen(),
            NotificationScreen(),
            SettingScreen(),
          ],
        ),
        bottomNavigationBar: CustomTabBar(
          tabsIcon: [
   FaIcon(FontAwesomeIcons.smile),
    FaIcon(FontAwesomeIcons.comment),
    FaIcon(FontAwesomeIcons.bell),
    FaIcon(Icons.settings_outlined),
  ],
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
        ),
      ),
    );
  }
}
