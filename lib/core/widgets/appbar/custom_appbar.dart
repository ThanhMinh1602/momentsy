// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';

// class CustomAppBar extends StatelessWidget {
//   const CustomAppBar({
//     super.key,
//     required this.avtUrl,
//   });

//   final String avtUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//           gradient:
//               LinearGradient(colors: [AppColor.kEBC894, AppColor.kB49EF4]),
//           borderRadius: BorderRadius.circular(borderRadius16)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () => Get.toNamed(AppRoutes.SETTING),
//             child: CircleAvatar(
//               backgroundImage: NetworkImage(avtUrl),
//             ),
//           ),
//           Text('Hi Minh',
//               style: AppStyle.bold32.copyWith(color: AppColor.white)),
//           Icon(
//             Icons.chat,
//             color: AppColor.white,
//             size: 32.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
