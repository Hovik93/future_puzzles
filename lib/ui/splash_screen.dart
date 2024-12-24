import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/ui/data_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          _checkOnboardingStatus();
        }
      },
    );
  }

  Future<void> _checkOnboardingStatus() async {
    bool onboardingSeen = await DataStorage.isOnboardingSeen();
    if (onboardingSeen) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/onBoarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.blue2,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 80.w),
          child: Text(
            'Future Puzzles',
            style: theme.headlineLarge?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
