// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/base/images.dart';

import 'package:future_puzzles/ui/page_screen/home_screen.dart';
import 'package:future_puzzles/ui/page_screen/profile_screen.dart';
import 'package:future_puzzles/ui/page_screen/settings_screen.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int? selectedIndex;
  HomePage({
    super.key,
    this.selectedIndex,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final list = [
    const HomeScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  int? _selectedIndex = 0;

  void onTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: BottomNavigationBar(
            backgroundColor: AppColors.white,
            currentIndex: _selectedIndex ?? 0,
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
                    color: _selectedIndex != 0 ? AppColors.grey2 : null,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.profile,
                    width: 22.w,
                    height: 22.w,
                    color: _selectedIndex != 1 ? AppColors.grey2 : null,
                  ),
                  label: 'profile'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.settings,
                    width: 22.w,
                    height: 22.w,
                    color: _selectedIndex != 2 ? AppColors.grey2 : null,
                  ),
                  label: 'Setting'),
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return list[_selectedIndex ?? 0];
  }
}
