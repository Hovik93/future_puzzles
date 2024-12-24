import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/data/riddles_data.dart';
import 'package:future_puzzles/ui/page_details/riddles/riddlesTopic.dart';
import 'package:future_puzzles/ui/widgets/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class Riddles extends StatefulWidget {
  String? title;
  String? beforeTitle;
  Riddles({super.key, this.title, this.beforeTitle});

  @override
  State<Riddles> createState() => _RiddlesState();
}

class _RiddlesState extends State<Riddles> {
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
                      riddlesData.length,
                      (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return RiddlesTopic(
                                title: "Topic",
                                beforeTitle: "Riddles",
                                riddlesData: riddlesData[index],
                              );
                            }),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.w),
                          margin: EdgeInsets.only(bottom: 10.w),
                          decoration: BoxDecoration(
                              color: AppColors.blue1,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${riddlesData[index]['category']}",
                                style: theme.titleMedium
                                    ?.copyWith(color: AppColors.white),
                              ),
                              Container(
                                width: 44.w,
                                height: 44.w,
                                decoration: BoxDecoration(
                                    color: AppColors.grey1.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppColors.white,
                                  size: 40,
                                ),
                              )
                            ],
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
