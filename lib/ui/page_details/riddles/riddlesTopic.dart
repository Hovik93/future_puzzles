import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/ui/page_details/riddles/riddle.dart';

// ignore: must_be_immutable
class RiddlesTopic extends StatefulWidget {
  String? title;
  String? beforeTitle;
  Map<String, dynamic> riddlesData;
  RiddlesTopic({
    super.key,
    this.title,
    this.beforeTitle,
    required this.riddlesData,
  });

  @override
  State<RiddlesTopic> createState() => _RiddlesTopicState();
}

class _RiddlesTopicState extends State<RiddlesTopic> {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.blue1,
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
          style: theme?.titleLarge?.copyWith(color: AppColors.white),
        ),
        const Expanded(
          child: SizedBox(),
        )
      ],
    );
  }

  Widget body({TextTheme? theme}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 30.w),
              child: appBar(theme: theme),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 100.w),
              child: Center(
                child: Text(
                  "${widget.riddlesData['category']}",
                  textAlign: TextAlign.center,
                  style: theme?.titleLarge
                      ?.copyWith(fontSize: 32, color: AppColors.green),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return Riddle(
                      title: "Riddle",
                      beforeTitle: "Riddles",
                      riddlesData: widget.riddlesData,
                    );
                  }),
                );
              },
              child: Container(
                width: double.infinity,
                height: 46.w,
                margin: EdgeInsets.only(bottom: 30.w),
                decoration: BoxDecoration(
                  color: AppColors.blue2,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'Start',
                    style: theme?.bodyMedium?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
