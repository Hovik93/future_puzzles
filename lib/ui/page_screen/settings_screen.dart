import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/base/constants.dart';
import 'package:future_puzzles/base/images.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final InAppReview inAppReview = InAppReview.instance;

  _launchURL({required String urlLink}) async {
    final Uri url = Uri.parse(urlLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: body(theme: theme),
    );
  }

// onTap: () {
//                   _launchURL(urlLink: privacyPolicyUrl);
//                 },
  Widget body({required TextTheme theme}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 30.w),
              child: appBar(theme: theme),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    _launchURL(urlLink: privacyPolicyUrl);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.privacySecurity,
                            color: AppColors.blue1,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            "Privacy & Security",
                            style: theme.bodyMedium,
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.w),
                  child: InkWell(
                    onTap: () {
                      _launchURL(urlLink: userAgreementUrl);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppImages.userAgreement,
                              color: AppColors.blue1,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              "User Agreement ",
                              style: theme.bodyMedium,
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (await inAppReview.isAvailable()) {
                      inAppReview.requestReview();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.leaveFeedback,
                            color: AppColors.blue1,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            "Leave Feedback",
                            style: theme.bodyMedium,
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget appBar({TextTheme? theme}) {
    return Text(
      'Settings',
      style: theme?.titleLarge,
    );
  }
}
