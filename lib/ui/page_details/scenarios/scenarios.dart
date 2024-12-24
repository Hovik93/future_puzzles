import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/data/scenarios_data.dart';
import 'package:future_puzzles/ui/page_details/scenarios/scenario_details.dart';
import 'package:future_puzzles/ui/widgets/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class Scenarios extends StatefulWidget {
  String? title;
  String? beforeTitle;
  Scenarios({super.key, this.title, this.beforeTitle});

  @override
  State<Scenarios> createState() => _ScenariosState();
}

class _ScenariosState extends State<Scenarios> {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 0,
      ),
      body: body(theme: theme),
    );
  }

  Widget body({required TextTheme theme}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
              child: appBar(theme: theme),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.w,
                    ),
                    ...List.generate(
                      scenariosData['scenarios'].length,
                      (index) => scenariosCard(
                        theme: theme,
                        scenario: scenariosData['scenarios'][index],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBar({TextTheme? theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5.w),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.grey2,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.beforeTitle ?? '',
                  style: theme?.titleMedium?.copyWith(color: AppColors.grey2),
                ),
              ],
            ),
          ),
        ),
        Text(
          widget.title ?? '',
          style: theme?.titleLarge,
        ),
        const Expanded(
          child: SizedBox(),
        )
      ],
    );
  }

  Widget scenariosCard(
      {required Map<String, dynamic> scenario, required TextTheme theme}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return ScenarioDetails(
                title: "Scenario",
                beforeTitle: "Scenarios",
                scenarioData: scenario,
              );
            }),
          );
        },
        child: Stack(
          children: [
            // Background Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: Image.asset(
                scenario['image'], // Замените на путь к изображению
                width: double.infinity,
                height: 220.w,
                fit: BoxFit.cover,
              ),
            ),
            // Overlay and content
            Container(
              height: 220.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
        
            Positioned(
              left: 8.w,
              top: 8.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: 260.w,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey1.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scenario['title'],
                          style: theme.titleMedium?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        // SizedBox(height: 4.w),
                        Text(
                          scenario['description'],
                          style: theme.titleSmall
                              ?.copyWith(color: AppColors.white, fontSize: 13.sp),
                          maxLines: 9,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Lock Icon (if points are required)
            Positioned(
              top: 8.w,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColors.grey1.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 30.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
