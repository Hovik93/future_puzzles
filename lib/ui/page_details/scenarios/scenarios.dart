import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/data/achievements_data.dart';
import 'package:future_puzzles/data/scenarios_data.dart';
import 'package:future_puzzles/ui/data_storage.dart';
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
  Map<String, int> achievements = {};
  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      achievements = await DataStorage.getAchievements();
      _updateAchievementsData();
      setState(() {});
    });
  }

  void _updateAchievementsData() {
    for (final achievement in achievementsData["achievements"]) {
      final achievementKey =
          achievement["title"].toLowerCase().replaceAll(' ', '_');
      if ((((achievements[achievementKey] ?? 0) >= 5) &&
              (achievementKey == "visionary")) ||
          (((achievements[achievementKey] ?? 0) >= 10) &&
              (achievementKey == "fast_learner")) ||
          (((achievements[achievementKey] ?? 0) >= 5) &&
              (achievementKey == "trend_spotter")) ||
          (((achievements[achievementKey] ?? 0) >= 50) &&
              (achievementKey == "quiz_whiz"))) {
        achievement['lock'] = false;
      } else if (achievementKey == "futurist") {
        final visionaryUnlocked = achievementsData["achievements"].firstWhere(
                (a) =>
                    a["title"].toLowerCase().replaceAll(' ', '_') ==
                    "visionary")['lock'] ==
            false;
        final fastLearnerUnlocked = achievementsData["achievements"].firstWhere(
                (a) =>
                    a["title"].toLowerCase().replaceAll(' ', '_') ==
                    "fast_learner")['lock'] ==
            false;
        final trendSpotterUnlocked = achievementsData["achievements"]
                .firstWhere((a) =>
                    a["title"].toLowerCase().replaceAll(' ', '_') ==
                    "trend_spotter")['lock'] ==
            false;

        if (visionaryUnlocked && fastLearnerUnlocked && trendSpotterUnlocked) {
          achievement['lock'] = false;
        } else {
          achievement['lock'] = true;
        }
      } else {
        achievement['lock'] = true;
      }
    }

    totalPoints = achievementsData["achievements"]
        .where((achievement) => !achievement["lock"])
        .fold<int>(
          0,
          (int sum, Map<String, dynamic> achievement) =>
              sum + (achievement["points"] as int? ?? 0),
        );
  }

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
                    ListView.builder(
                      itemCount: scenariosData['scenarios'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final scenario = scenariosData["scenarios"][index];
                        final bool isUnlocked =
                            (index == 0 && totalPoints >= 500) ||
                                (index == 1 && totalPoints >= 1000);
                        return scenariosCard(
                            theme: theme,
                            scenario: scenario,
                            isUnlocked: isUnlocked);
                      },
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
      {required Map<String, dynamic> scenario,
      required TextTheme theme,
      required bool isUnlocked}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: GestureDetector(
        onTap: isUnlocked
            ? () {
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
              }
            : () {},
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: Image.asset(
                scenario['image'],
                width: double.infinity,
                height: 220.w,
                fit: BoxFit.cover,
              ),
            ),
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
                        Text(
                          scenario['description'],
                          style: theme.bodySmall?.copyWith(
                              color: AppColors.white, fontSize: 13.sp),
                          maxLines: 9,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                  isUnlocked == false
                      ? Icons.lock_outline_rounded
                      : Icons.lock_open_rounded,
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
