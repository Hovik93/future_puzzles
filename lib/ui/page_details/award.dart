import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/ui/widgets/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class Award extends StatefulWidget {
  String? title;
  String? beforeTitle;
  Map<String, dynamic>? achievementsData;
  Award({super.key, this.title, this.beforeTitle, this.achievementsData});

  @override
  State<Award> createState() => _AwardState();
}

class _AwardState extends State<Award> {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 1,
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 30.w),
              alignment: Alignment.center,
              child: Image.asset(widget.achievementsData?['image']),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.achievementsData?['name']}",
                  style: theme.titleMedium,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 5.w),
                  decoration: BoxDecoration(
                    color: AppColors.blue1,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "${widget.achievementsData?['points']}",
                    style: theme.titleLarge?.copyWith(color: AppColors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.w,
            ),
            Text(
              "${widget.achievementsData?['description']}",
              textAlign: TextAlign.center,
              style: theme.bodyMedium,
            ),
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
}
