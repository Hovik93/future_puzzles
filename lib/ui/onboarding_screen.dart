import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/base/images.dart';
import 'package:future_puzzles/ui/data_storage.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Map<String, dynamic>> onBoardingImages = [
    {
      'image': AppImages.onboarding1,
      'title': "Welcome to Future Puzzles!",
      'description':
          "Dive into the world of tomorrow with us! Explore fascinating puzzles and challenges that will spark your imagination about the future.",
      'index': 0
    },
    {
      'image': AppImages.onboarding2,
      'title': "Discover Tomorrow's Innovations",
      'description':
          "Uncover potential inventions and technologies that could change our lives in the next 10, 50, or even 100 years. Get ready to think ahead!",
      'index': 1
    },
    {
      'image': AppImages.onboarding3,
      'title': "Engage and Learn",
      'description':
          "Test your knowledge about ecological changes, social structures, and more. Join our community and use our insights about the future!",
      'index': 2
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Widget body() {
    final TextTheme theme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
            itemCount: onBoardingImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(onBoardingImages[index]['image']),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      flex: 6,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        // color: Colors.green,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20.w),
                              child: Text(
                                onBoardingImages[index]['title'],
                                textAlign: TextAlign.start,
                                style: theme.titleMedium,
                              ),
                            ),
                            Text(
                              onBoardingImages[index]['description'],
                              textAlign: TextAlign.center,
                              style: theme.bodyMedium,
                            ),
                            index == onBoardingImages.last['index']
                                ? GestureDetector(
                                    onTap: () async {
                                      bool showOnboarding =
                                          await DataStorage.isOnboardingSeen();
                                      if (!showOnboarding) {
                                        // Показать онбординг
                                        await DataStorage.setOnboardingSeen();
                                      }
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    },
                                    child: Container(
                                      height: 44.w,
                                      margin: EdgeInsets.only(
                                        top: 20.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.blue2,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Start',
                                          style: theme.titleLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 20.w,
                                  ),

                            /// dotes
                            Padding(
                              padding: index == onBoardingImages.last['index']
                                  ? EdgeInsets.only(bottom: 10.w)
                                  : EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    onBoardingImages.length,
                                    (indexDote) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: 8.w,
                                      height: 8.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index == indexDote
                                            ? AppColors.blue1
                                            : AppColors.blue1.withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///
                            SizedBox(
                              height: 10.w,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
