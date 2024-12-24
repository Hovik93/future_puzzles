// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/base/images.dart';
import 'package:future_puzzles/ui/home.dart';

// ignore: must_be_immutable
class BottomNavigationBarWidget extends StatefulWidget {
  int selectedIndex;
  BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  void onTap(int index) {
    if (widget.selectedIndex != index) {
      setState(() {
        widget.selectedIndex = index;
      });
    }

    if (index == 2) {}

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(selectedIndex: index),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: widget.selectedIndex,
          elevation: 0,
          selectedFontSize: 13.sp,
          unselectedFontSize: 13.sp,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: AppColors.grey2,
          // selectedItemColor: AppColors.transparent,
          selectedIconTheme: IconThemeData(color: AppColors.transparent),
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.home,
                  width: 22.w,
                  height: 22.w,
                  color: widget.selectedIndex != 0 ? AppColors.grey2 : null,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.profile,
                  width: 22.w,
                  height: 22.w,
                  color: widget.selectedIndex != 1 ? AppColors.grey2 : null,
                ),
                label: 'profile'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.settings,
                  width: 22.w,
                  height: 22.w,
                  color: widget.selectedIndex != 2 ? AppColors.grey2 : null,
                ),
                label: 'Setting'),
          ],
        ),
      ),
    );
  }
}
