import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/base/images.dart';
import 'package:future_puzzles/ui/data_storage.dart';

class Riddle extends StatefulWidget {
  final String? title;
  final String? beforeTitle;
  final Map<String, dynamic> riddlesData;

  const Riddle({
    super.key,
    this.title,
    this.beforeTitle,
    required this.riddlesData,
  });

  @override
  State<Riddle> createState() => _RiddleState();
}

class _RiddleState extends State<Riddle> {
  late List<Map<String, dynamic>> randomQuizzes;
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool showAnswer = false;
  int correctAnswers = 0;
  bool showResult = false;
  String buttonText = "";

  @override
  void initState() {
    super.initState();
    randomQuizzes =
        (widget.riddlesData['puzzles'] as List<Map<String, dynamic>>).toList()
          ..shuffle();
    randomQuizzes = randomQuizzes.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final currentQuestion = randomQuizzes[currentQuestionIndex];
    return Scaffold(
      backgroundColor: ((showAnswer && !showResult) || showResult)
          ? AppColors.blue1
          : AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(theme: theme),
              const Spacer(),
              if (!showAnswer && !showResult)
                questionTitle(theme, currentQuestion['title']),
              if (!showAnswer && !showResult) SizedBox(height: 25.w),
              if (!showAnswer && !showResult)
                questionDescription(theme, currentQuestion['description']),
              if (!showAnswer && !showResult) SizedBox(height: 50.w),
              if (!showAnswer && !showResult)
                ...buildOptions(theme, currentQuestion['options']),
              if (showAnswer && !showResult)
                correctAnswerUI(theme, currentQuestion),
              if (showResult) buildResultScreen(theme),
              const Spacer(),
              nextButton(theme),
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
          !showResult
              ? !showAnswer
                  ? widget.title ?? ''
                  : "Answer"
              : "Result",
          style: theme?.titleLarge?.copyWith(color: AppColors.white),
        ),
        const Expanded(
          child: SizedBox(),
        )
      ],
    );
  }

  Widget questionTitle(TextTheme theme, String title) {
    return Center(
      child: Text(
        title,
        style: theme.titleMedium?.copyWith(
          color: AppColors.blue1,
        ),
      ),
    );
  }

  Widget questionDescription(TextTheme theme, String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 6.w),
      decoration: BoxDecoration(
        color: AppColors.blue1,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: theme.bodyMedium?.copyWith(color: AppColors.white),
      ),
    );
  }

  List<Widget> buildOptions(TextTheme theme, List<String> options) {
    return options.asMap().entries.map((entry) {
      final option = entry.value;

      return GestureDetector(
        onTap: () async {
          setState(() {
            selectedOption = option;
            if (option.split(':')[0] ==
                randomQuizzes[currentQuestionIndex]['correct_answer']) {
              correctAnswers++;
              if (widget.riddlesData['category'] == "Future Technologies") {
                DataStorage.updateAchievement("visionary", 1);
              }
              DataStorage.updateAchievement("fast_learner", 1);
            }
          });
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.w),
              padding: EdgeInsets.only(
                top: 8.w,
                right: 10.w,
                left: 10.w,
              ),
              decoration: BoxDecoration(
                color: selectedOption == option
                    ? AppColors.blue1
                    : AppColors.grey1.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                option.split(':')[0],
                style: theme.titleLarge?.copyWith(
                  fontSize: 32.sp,
                  color: AppColors.white,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.w),
                child: Text(
                  option.split(': ')[1],
                  style: theme.bodyMedium?.copyWith(
                    color: selectedOption == option
                        ? AppColors.blue1
                        : AppColors.grey2,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget correctAnswerUI(TextTheme theme, Map<String, dynamic> question) {
    final correctAnswer = question['correct_answer'];
    final explanation = question['explanation'];
    return Padding(
      padding: EdgeInsets.only(bottom: 100.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Correct answer",
                style: theme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.only(top: 1.w, left: 8.w, right: 8.w),
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  correctAnswer,
                  style: theme.titleMedium?.copyWith(
                    color: AppColors.blue1,
                    fontSize: 32.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.w),
          Text(
            explanation,
            textAlign: TextAlign.center,
            style: theme.bodyMedium?.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget nextButton(TextTheme theme) {
    return GestureDetector(
      onTap: selectedOption == null
          ? null
          : () {
              if (!showResult) {
                if (!showAnswer) {
                  setState(() {
                    showAnswer = true;
                  });
                } else {
                  if (currentQuestionIndex < randomQuizzes.length - 1) {
                    setState(() {
                      currentQuestionIndex++;
                      selectedOption = null;
                      showAnswer = false;
                    });
                  } else {
                    setState(() {
                      showAnswer = false;
                      showResult = true;
                    });
                  }
                }
              } else {
                switch (buttonText) {
                  case 'Try again':
                    setState(() {
                      currentQuestionIndex = 0;
                      correctAnswers = 0;
                      selectedOption = null;
                      showAnswer = false;
                      showResult = false;
                      randomQuizzes.shuffle();
                    });
                    break;

                  case 'New riddles':
                    setState(() {
                      currentQuestionIndex = 0;
                      correctAnswers = 0;
                      selectedOption = null;
                      showAnswer = false;
                      showResult = false;
                      randomQuizzes = (widget.riddlesData['puzzles']
                              as List<Map<String, dynamic>>)
                          .toList()
                        ..shuffle();
                      randomQuizzes = randomQuizzes.take(5).toList();
                    });
                    break;

                  case 'Next':
                    Navigator.pop(context);
                    break;

                  default:
                }
              }
            },
      child: Container(
        width: double.infinity,
        height: 46.w,
        margin: EdgeInsets.only(bottom: 20.w),
        decoration: BoxDecoration(
          color: selectedOption == null
              ? AppColors.blue2.withOpacity(0.3)
              : AppColors.blue2,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            !showResult ? "Next" : buttonText,
            style: theme.bodyMedium?.copyWith(
              color: AppColors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResultScreen(TextTheme theme) {
    String title;
    String message;
    String imagePath;
    String? backgroundPath;

    if (correctAnswers == randomQuizzes.length) {
      title = "Trend Spotter";
      message =
          "Congratulations! You correctly identified ${randomQuizzes.length} major technological trends in the tests. You have earned 100 points.";

      imagePath = AppImages.award;
      buttonText = "Next";
    } else if (correctAnswers > randomQuizzes.length / 2) {
      title = "Congratulations!";
      message =
          "You've successfully answered more than half of the questions! Your knowledge about the future is impressive. Keep exploring and stay curious—there's so much more to discover!";
      backgroundPath = AppImages.good1;
      imagePath = AppImages.good;
      buttonText = "New riddles";
    } else {
      title = "Oops!";
      message =
          "It looks like you answered less than half of the questions correctly. Don’t worry! Every challenge is a learning opportunity.";
      backgroundPath = AppImages.wrong1;
      imagePath = AppImages.wrong;
      buttonText = "Try again";
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        if (backgroundPath != null)
          Positioned(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 190.w,
              child: Image.asset(
                backgroundPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 200.w),
            SizedBox(height: 20.w),
            Text(
              title,
              style: theme.titleLarge?.copyWith(
                color: AppColors.green,
                fontSize: 32.sp,
              ),
            ),
            SizedBox(height: 10.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.bodyMedium?.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
            SizedBox(height: 30.w),
          ],
        ),
      ],
    );
  }
}
