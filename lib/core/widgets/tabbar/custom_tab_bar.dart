import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';
import 'package:momentsy/core/constants/app_dimensions.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    this.tabController,
    this.tabsTitle,
    this.tabsIcon,
    this.padding,
  }) : assert(
         (tabsTitle != null && tabsIcon == null) ||
             (tabsTitle == null && tabsIcon != null),
         'Either tabsTitle or tabsIcon must be provided, not both.',
       );

  final TabController? tabController;
  final List<String>? tabsTitle;
  final List<Widget>? tabsIcon;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: padding,

      controller: tabController,
      indicatorAnimation: TabIndicatorAnimation.elastic,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius32),
        color: AppColor.primary,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.transparent,
      dividerHeight: 0,
      unselectedLabelColor: AppColor.black,
      labelColor: AppColor.white,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      tabs:
          tabsIcon != null
              ? tabsIcon!.map((icon) => Tab(icon: icon)).toList()
              : tabsTitle!.map((title) => Tab(text: title)).toList(),
    );
  }
}
