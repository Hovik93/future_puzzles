import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/base/images.dart';
import 'package:future_puzzles/ui/data_storage.dart';
import 'package:future_puzzles/ui/page_details/articles/article_details.dart';
import 'package:future_puzzles/ui/page_details/articles/articles.dart';
import 'package:future_puzzles/ui/page_details/award.dart';
import 'package:future_puzzles/ui/page_details/quizzes/quizzes.dart';
import 'package:future_puzzles/ui/page_details/recent.dart';
import 'package:future_puzzles/ui/page_details/riddles/riddles.dart';
import 'package:future_puzzles/ui/page_details/scenarios/scenarios.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> categories = [
    {
      "image": AppImages.predictionsAndTrends,
      "title": "Future Predictions and Trends",
      "description": "Articles",
    },
    {
      "image": AppImages.riddlesAbout,
      "title": "Riddles about the future",
      "description": "Interactive tasks with answers",
    },
    {
      "image": AppImages.quizzes,
      "title": "Quizzes",
      "description": "Guess the Future",
    },
    {
      "image": AppImages.scenarios,
      "title": "Scenarios",
      "description": "The future of the planet and people",
    }
  ];

  List<Map<String, dynamic>> recentData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      recentData = await DataStorage.getRecentData();

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: body(theme: theme),
    );
  }

  Widget body({required TextTheme theme}) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 30.w),
              child: appBar(theme: theme),
            ),
            Text(
              "Categories",
              style: theme.titleMedium,
            ),
            SizedBox(height: 10.w),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      categories.length,
                      (index) => GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return Articles(
                                    title: "Articles",
                                    beforeTitle: "Home",
                                  );
                                }),
                              ).then((e) async {
                                recentData = await DataStorage.getRecentData();
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return Riddles(
                                    title: "Riddles",
                                    beforeTitle: "Home",
                                  );
                                }),
                              ).then((e) async {
                                recentData = await DataStorage.getRecentData();
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                              break;
                            case 2:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return Quizzes(
                                    title: "Quizzes",
                                    beforeTitle: "Home",
                                  );
                                }),
                              ).then((e) async {
                                recentData = await DataStorage.getRecentData();
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                              break;
                            case 3:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return Scenarios(
                                    title: "Scenarios",
                                    beforeTitle: "Home",
                                  );
                                }),
                              ).then((e) async {
                                recentData = await DataStorage.getRecentData();
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                              break;
                            default:
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 194.w,
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(categories[index]['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.w),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                    child: Container(
                                      width: 212.w,
                                      padding: EdgeInsets.all(4.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            categories[index]['title'],
                                            style: theme.bodyMedium?.copyWith(
                                                color: AppColors.white),
                                          ),
                                          SizedBox(height: 4.w),
                                          Text(
                                            categories[index]['description'],
                                            style: theme.bodyMedium?.copyWith(
                                              fontSize: 13.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                    recentData.isNotEmpty
                        ? recentBlock(theme: theme)
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar({TextTheme? theme}) {
    return Text(
      'Welcome! User',
      style: theme?.titleLarge,
    );
  }

  Widget recentBlock({TextTheme? theme}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent',
              style: theme?.titleMedium,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return Recent(
                      title: "Recent",
                      beforeTitle: "Home",
                      recentData: recentData,
                    );
                  }),
                );
              },
              child: Text(
                'see all',
                style: theme?.bodyMedium?.copyWith(color: AppColors.blue1),
              ),
            ),
          ],
        ),
        recentData.isNotEmpty
            ? SizedBox(
                height: 130.w,
                child: ListView.builder(
                    itemCount: recentData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          switch (recentData[index]['type']) {
                            case "Award":
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return Award(
                                    title: "Award",
                                    beforeTitle: "Profile",
                                    achievementsData: recentData[index]['data'],
                                  );
                                }),
                              );
                              break;
                            case "Article":
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return ArticlesDetails(
                                    title: "Article",
                                    beforeTitle: "Articles",
                                    articleData: recentData[index]['data'],
                                  );
                                }),
                              );
                            default:
                          }
                        },
                        child: Container(
                          width: 93.w,
                          margin: EdgeInsets.only(right: 34.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  recentData[index]['data']['image'],
                                  width: 93.w,
                                  height: 93.w,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3.w),
                                child: Center(
                                  child: Text(
                                    "${recentData[index]['type']}",
                                    style: theme?.bodyMedium,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : SizedBox.shrink()
      ],
    );
  }
}
