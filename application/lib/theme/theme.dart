import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextStyles {
  static TextStyle headlineSmall = TextStyle(
      color: CustomColors.gray900,
      fontSize: 24.sp,
      fontWeight: FontWeight.w700
  );

  static TextStyle labelMedium = TextStyle(
      color: CustomColors.gray900,
      fontSize: 10.sp,
      fontWeight: FontWeight.w600
  );

  static TextStyle titleLarge = TextStyle(
      color: CustomColors.gray900,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700
  );

  static TextStyle titleMedium = TextStyle(
      color: CustomColors.gray900,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700
  );

  static TextStyle titleSmall = TextStyle(
      color: CustomColors.gray700,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500
  );
}

class CustomColors {
  static Color get black900 => Color(0xFF000000);
  static Color get blueGray400 => Color(0xFF888888);
  static Color get gray500 => Color(0xFF9E9E9E);
  static Color get gray700 => Color(0xFF616161);
  static Color get gray900 => Color(0xFF212121);
}