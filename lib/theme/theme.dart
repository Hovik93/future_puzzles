import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      fontFamily: "Expletus Sans",
    ),
    bodyMedium: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 17.sp,
      fontFamily: "Expletus Sans",
    ),
    titleMedium: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 22.sp,
      fontFamily: "Expletus Sans",
    ),
    titleLarge: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 24.sp,
      fontFamily: "Expletus Sans",
    ),
    headlineLarge: TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w700,
      fontSize: 36.sp,
      fontFamily: "Expletus Sans",
    ),
  ),
);
