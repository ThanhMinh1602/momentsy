import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabsTitle,
  });

  final TabController tabController;
  final List<String> tabsTitle;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius32),
        color: AppColor.primary,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorAnimation: TabIndicatorAnimation.linear,
      dividerHeight: 0,
      controller: tabController,
      unselectedLabelColor: AppColor.black,

      labelColor: AppColor.white,
      tabs: tabsTitle.map((tabTitle) => Tab(text: tabTitle)).toList(),
    );
  }
}
