import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_puzzles/base/colors.dart';
import 'package:future_puzzles/base/images.dart';

class Question extends StatefulWidget {
  final String? title;
  final String? beforeTitle;
  final Map<String, dynamic> quizData;

  const Question({
    super.key,
    this.title,
    this.beforeTitle,
    required this.quizData,
  });

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
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
    // Выбираем случайные 5 вопросов
    randomQuizzes = (widget.quizData['quizzes'] as List<Map<String, dynamic>>)
        .toList()
      ..shuffle();
    randomQuizzes = randomQuizzes.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final currentQuestion = randomQuizzes[currentQuestionIndex];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(theme: theme),
              Spacer(),
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
              Spacer(),
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
          style: theme?.titleLarge,
        ),
        const Expanded(
          child: SizedBox(),
        )
      ],
    );
  }

  Widget questionTitle(TextTheme theme, String title) {
    return Container(
      width: double.infinity,
      height: 50.w,
      padding: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(
        color: AppColors.blue1,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          title,
          style: theme.titleMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget questionDescription(TextTheme theme, String description) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: theme.bodyMedium,
    );
  }

  List<Widget> buildOptions(TextTheme theme, List<String> options) {
    return options.asMap().entries.map((entry) {
      // final index = entry.key;
      final option = entry.value;

      return GestureDetector(
        onTap: () {
          setState(() {
            selectedOption = option;
            if (option.split(':')[0] ==
                randomQuizzes[currentQuestionIndex]['correct_answer']) {
              correctAnswers++; // Увеличиваем счетчик правильных ответов
            }
          });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10.w),
          padding:
              EdgeInsets.only(top: 6.w, bottom: 3.w, left: 16.w, right: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color:
                  selectedOption == option ? AppColors.blue1 : AppColors.grey2,
            ),
          ),
          child: Row(
            children: [
              Text(
                option.split(':')[0],
                style: theme.titleLarge?.copyWith(
                  fontSize: 32.sp,
                  color: selectedOption == option
                      ? AppColors.blue1
                      : AppColors.grey2,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  option.split(': ')[1],
                  style: theme.bodyMedium?.copyWith(
                    color: selectedOption == option
                        ? AppColors.blue1
                        : AppColors.grey2,
                  ),
                ),
              ),
            ],
          ),
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
                  color: AppColors.blue1,
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: AppColors.blue1,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  correctAnswer,
                  style: theme.titleMedium?.copyWith(
                    color: AppColors.white,
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
            style: theme.bodyMedium,
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
                  // Если правильный ответ ещё не показан
                  setState(() {
                    showAnswer = true;
                  });
                } else {
                  // Если правильный ответ показан
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
                    // Перезапуск текущего набора вопросов
                    setState(() {
                      currentQuestionIndex = 0;
                      correctAnswers = 0;
                      selectedOption = null;
                      showAnswer = false;
                      showResult = false;
                      randomQuizzes.shuffle(); // Перемешиваем вопросы
                    });
                    break;

                  case 'New quiz':
                    // Начать новый квиз (можно перезапустить другой набор данных)
                    setState(() {
                      currentQuestionIndex = 0;
                      correctAnswers = 0;
                      selectedOption = null;
                      showAnswer = false;
                      showResult = false;
                      randomQuizzes = (widget.quizData['quizzes']
                              as List<Map<String, dynamic>>)
                          .toList()
                        ..shuffle();
                      randomQuizzes = randomQuizzes.take(5).toList();
                    });
                    break;

                  case 'Next':
                    // Вернуться или перейти к следующему разделу/экрану
                    Navigator.pop(context); // Или другой переход
                    break;

                  default:
                    // В случае чего-то неожиданного
                    debugPrint("Неизвестная кнопка: $buttonText");
                }
              }
            },
      child: Container(
        width: double.infinity,
        height: 46.w,
        decoration: BoxDecoration(
          color: selectedOption == null
              ? AppColors.blue2.withOpacity(0.3)
              : AppColors.blue2,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            // (buttonText == "New quiz")
            //     ? "New quiz"
            //     : (buttonText == "Try again")
            //         ? "Try again"
            //         : "Next",

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
      imagePath = AppImages.good;
      buttonText = "New quiz";
    } else {
      title = "Oops!";
      message =
          "It looks like you answered less than half of the questions correctly. Don’t worry! Every challenge is a learning opportunity.";
      imagePath = AppImages.wrong;
      buttonText = "Try again";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 200.h),
        SizedBox(height: 20.h),
        Text(
          title,
          style: theme.titleLarge?.copyWith(
            color: AppColors.blue1,
            fontSize: 24.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.bodyMedium,
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
