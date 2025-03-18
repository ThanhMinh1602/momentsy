import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';

// FontWeight.w100	Thin (Mỏng nhất)
// FontWeight.w200	Extra Light (Siêu mỏng)
// FontWeight.w300	Light (Mỏng)
// FontWeight.w400	Normal (Bình thường, mặc định)
// FontWeight.w500	Medium (Trung bình)
// FontWeight.w600	Semi Bold (Hơi đậm)
// FontWeight.w700	Bold (Đậm)
// FontWeight.w800	Extra Bold (Siêu đậm)
// FontWeight.w900	Black (Đậm nhất)
class AppStyle {
  static TextStyle bold32 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );
  static TextStyle bold18 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );
  static TextStyle bold12 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );
  static TextStyle bold14 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    color: AppColor.white,
  );
  static TextStyle bold16 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: AppColor.white,
  );
  static TextStyle regular12 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColor.grey,
  );
  static TextStyle regular14 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  );
  static TextStyle regular10 = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: AppColor.grey,
  );
  static TextStyle medium12 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColor.grey,
  );
  static TextStyle medium14 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColor.k1A1C1E,
  );

  static TextStyle semiBold12 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColor.primary,
  );
}
