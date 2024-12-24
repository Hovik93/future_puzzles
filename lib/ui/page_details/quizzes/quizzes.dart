import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/data/quizzes_data.dart';
import 'package:future_puzzles/ui/page_details/quizzes/topic.dart';
import 'package:future_puzzles/ui/widgets/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class Quizzes extends StatefulWidget {
  String? title;
  String? beforeTitle;
  Quizzes({super.key, this.title, this.beforeTitle});

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
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
                      quizzesData.length,
                      (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return Topic(
                                title: "Topic",
                                beforeTitle: "Quizzes",
                                quizData: quizzesData[index],
                              );
                            }),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5.w),
                          margin: EdgeInsets.only(bottom: 10.w),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppColors.blue1,
                                width: 1.w,
                              ),
                              bottom: BorderSide(
                                color: AppColors.blue1,
                                width: 1.w,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${quizzesData[index]['category']}",
                              style: theme.titleMedium,
                            ),
                          ),
                        ),
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
}
