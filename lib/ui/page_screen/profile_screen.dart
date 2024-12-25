import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/data/achievements_data.dart';
import 'package:future_puzzles/data/scenarios_data.dart';
import 'package:future_puzzles/ui/data_storage.dart';
import 'package:future_puzzles/ui/page_details/award.dart';
import 'package:future_puzzles/ui/page_details/scenarios/scenario_details.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "User";
  bool isEditingName = false;
  Map<String, int> achievements = {};
  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
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

  Future<void> _loadUserName() async {
    final name = await DataStorage.getUserName();
    setState(() {
      userName = name;
    });
  }

  Future<void> _saveUserName(String name) async {
    await DataStorage.setUserName(name);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(theme: theme),
              SizedBox(height: 20.w),
              userNameBlock(theme: theme),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      userInfoSection(theme: theme),
                      SizedBox(
                        height: 100.w,
                      ),
                      Column(
                        children: [
                          achievementsSection(theme: theme),
                          SizedBox(height: 30.w),
                          unlockedScenariosSection(theme: theme),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar({required TextTheme theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profile',
          style: theme.titleLarge,
        ),
      ],
    );
  }

  Widget userNameBlock({required TextTheme theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isEditingName
            ? Expanded(
                child: TextField(
                  autofocus: true,
                  onSubmitted: (value) {
                    setState(() {
                      userName = value.isNotEmpty ? value : "User";
                      isEditingName = false;
                    });
                    _saveUserName(userName);
                  },
                  style: theme.titleMedium?.copyWith(
                    color: AppColors.blue1,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    hintStyle: theme.bodyMedium?.copyWith(
                      color: AppColors.grey2,
                    ),
                  ),
                ),
              )
            : Text(
                userName,
                style: theme.titleMedium?.copyWith(color: AppColors.blue1),
              ),
        GestureDetector(
          onTap: () {
            setState(() {
              isEditingName = !isEditingName;
            });
          },
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColors.grey1.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.edit_note_sharp,
              color: AppColors.blue1,
              size: 32.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget userInfoSection({required TextTheme theme}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Number of points",
                style: theme.titleMedium,
              ),
              Container(
                height: 40.w,
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.w),
                decoration: BoxDecoration(
                  color: AppColors.blue1,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "$totalPoints",
                    style: theme.titleLarge?.copyWith(color: AppColors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Number of riddles",
              style: theme.titleMedium,
            ),
            Container(
              height: 40.w,
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.w),
              decoration: BoxDecoration(
                color: AppColors.blue1,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  "${achievements['fast_learner']}",
                  style: theme.titleLarge?.copyWith(color: AppColors.white),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget profileStatCard({
    required String title,
    required String value,
    required TextTheme theme,
  }) {
    return Expanded(
      child: Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: theme.titleLarge?.copyWith(color: Colors.blue),
              ),
              SizedBox(height: 5.h),
              Text(
                title,
                style: theme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget achievementsSection({required TextTheme theme}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Achievements and awards",
          style: theme.titleMedium,
        ),
        SizedBox(height: 10.w),
        SizedBox(
          width: double.infinity,
          height: 93.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: achievementsData["achievements"].length,
            itemBuilder: (context, index) {
              final achievement = achievementsData["achievements"][index];
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
                final visionaryUnlocked = achievementsData["achievements"]
                        .firstWhere((a) =>
                            a["title"].toLowerCase().replaceAll(' ', '_') ==
                            "visionary")['lock'] ==
                    false;

                final fastLearnerUnlocked = achievementsData["achievements"]
                        .firstWhere((a) =>
                            a["title"].toLowerCase().replaceAll(' ', '_') ==
                            "fast_learner")['lock'] ==
                    false;

                final trendSpotterUnlocked = achievementsData["achievements"]
                        .firstWhere((a) =>
                            a["title"].toLowerCase().replaceAll(' ', '_') ==
                            "trend_spotter")['lock'] ==
                    false;

                if (visionaryUnlocked &&
                    fastLearnerUnlocked &&
                    trendSpotterUnlocked) {
                  achievement['lock'] = false;
                } else {
                  achievement['lock'] = true;
                }
              } else {
                achievement['lock'] = true;
              }
              return GestureDetector(
                onTap: (achievement['lock'] == false)
                    ? () async {
                        await DataStorage.addRecentData({
                          "type": "Award",
                          "data": achievementsData["achievements"][index],
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            return Award(
                              title: "Award",
                              beforeTitle: "Profile",
                              achievementsData: achievementsData["achievements"]
                                  [index],
                            );
                          }),
                        );
                      }
                    : () {},
                child: Container(
                  width: 93.w,
                  height: 93.w,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    image: DecorationImage(
                      image: AssetImage(
                        achievementsData["achievements"][index]["image"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (achievement['lock'] == true)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.w),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: AppColors.grey1.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: achievement['lock'] == true
                            ? Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white,
                                size: 32.w,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget unlockedScenariosSection({required TextTheme theme}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Unlocked scenarios",
          style: theme.titleMedium,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: double.infinity,
          height: 93.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: scenariosData["scenarios"].length,
            itemBuilder: (context, index) {
              final scenario = scenariosData["scenarios"][index];
              final isUnlocked = (index == 0 && totalPoints >= 500) ||
                  (index == 1 && totalPoints >= 1000);

              return GestureDetector(
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
                child: Container(
                  width: 93.w,
                  height: 93.w,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    image: DecorationImage(
                      image: AssetImage(
                        scenario["image"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!isUnlocked)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.w),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: AppColors.grey1.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Icon(
                          !isUnlocked
                              ? Icons.lock_outline_rounded
                              : Icons.lock_open_rounded,
                          color: Colors.white,
                          size: 32.w,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
