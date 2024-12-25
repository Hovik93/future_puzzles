import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/ui/data_storage.dart';
import 'package:future_puzzles/ui/page_details/articles/article_details.dart';
import 'package:future_puzzles/ui/page_details/quizzes/question.dart';

// ignore: must_be_immutable
class ScenarioDetails extends StatefulWidget {
  String? title;
  String? beforeTitle;
  Map<String, dynamic> scenarioData;

  ScenarioDetails({
    super.key,
    this.title,
    this.beforeTitle,
    required this.scenarioData,
  });

  @override
  State<ScenarioDetails> createState() => _ScenarioDetailsState();
}

class _ScenarioDetailsState extends State<ScenarioDetails> {
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
              Padding(
                padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                child: appBar(theme: theme),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.w),
                        child: Image.asset(
                          widget.scenarioData['image'],
                          width: double.infinity,
                          height: 362.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: Text(
                          widget.scenarioData['title'],
                          style: theme.titleMedium?.copyWith(
                            color: AppColors.blue1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        child: Text(
                          widget.scenarioData["description"],
                          style: theme.bodyMedium,
                        ),
                      ),
                      Text(
                        "Content",
                        style: theme.titleMedium?.copyWith(
                          color: AppColors.blue1,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      contentCard(
                        theme: theme,
                        title: "Article",
                        images: widget.scenarioData['content']["article"]
                            ["image"],
                        description: widget.scenarioData['content']["article"]
                            ['title'],
                        onTap: () async {
                          await DataStorage.addRecentData({
                            "type": "Article",
                            "data": widget.scenarioData['content']["article"],
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return ArticlesDetails(
                                title: "Article",
                                beforeTitle: "Articles",
                                articleData: widget.scenarioData['content']
                                    ["article"],
                              );
                            }),
                          );
                        },
                      ),
                      SizedBox(height: 10.w),
                      contentCard(
                        theme: theme,
                        title: "Quiz",
                        images: widget.scenarioData['content']["puzzle"]
                            ["image"],
                        description:
                            "Answer the questions and earn prize points",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return Question(
                                title: "Question",
                                beforeTitle: "Quizzes",
                                quizData: widget.scenarioData['content']
                                    ["puzzle"],
                              );
                            }),
                          );
                        },
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
                Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.grey2,
                ),
                SizedBox(width: 5.w),
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
        Expanded(child: SizedBox()),
      ],
    );
  }

  Widget contentCard({
    required TextTheme theme,
    required String title,
    required String description,
    required VoidCallback onTap,
    required String images,
  }) {
    return Container(
      width: double.infinity,
      height: 120.w,
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        image: DecorationImage(
          image: AssetImage(images),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(12.w),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.w),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      width: 239.w,
                      padding: EdgeInsets.all(5.w),
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      decoration: BoxDecoration(
                        color: AppColors.grey1.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 5.w),
                          Text(
                            description,
                            style: theme.bodySmall
                                ?.copyWith(color: Colors.white, fontSize: 13.w),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.w),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: AppColors.grey1.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
