import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/data/articles_data.dart';
import 'package:future_puzzles/ui/data_storage.dart';
import 'package:future_puzzles/ui/page_details/articles/article_details.dart';
import 'package:future_puzzles/ui/widgets/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class Articles extends StatefulWidget {
  String? title;
  String? beforeTitle;
  Articles({super.key, this.title, this.beforeTitle});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
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
                      articlesData['articles'].length,
                      (index) => articleCard(
                        article: articlesData['articles'][index],
                        theme: theme,
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

  Widget articleCard(
      {required Map<String, dynamic> article, required TextTheme theme}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: GestureDetector(
        onTap: () async {
          await DataStorage.addRecentData({
            "type": "Article",
            "data": article,
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return ArticlesDetails(
                title: "Article",
                beforeTitle: "Articles",
                articleData: article,
              );
            }),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.w,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.w),
                child: Image.asset(
                  article['image'],
                  width: double.infinity,
                  height: 362.w,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.w, horizontal: 8.w),
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey1.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Text(
                      article['title'],
                      style: theme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
