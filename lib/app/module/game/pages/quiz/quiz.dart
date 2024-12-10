import 'package:flutter/material.dart';
import 'package:game/app/module/game/pages/gallery.dart';
import 'package:game/app/module/game/pages/quiz/quiz_end_empty.dart';
import 'package:game/app/module/game/pages/quiz/quiz_question.dart';
import 'package:game/app/module/game/pages/quiz/quiz_question_model.dart';
import 'package:game/data/storage/storage.dart';
import 'package:game/generated/assets_flame_images.dart';

import '../../../../app.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<QuizQuestionModel> questionsList = [];
  int currentIndex = 1;
  PageController pageController = PageController();
  int correctAnswers = 0;

  @override
  void initState() {
    var answeredQuestions = AppStorage.answeredQuestions.val;

    questionsList = listQuestions;

    questionsList
        .removeWhere((element) => answeredQuestions.contains(element.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (questionsList.isEmpty) {
      return EndPopUpEmpty();
    }
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AssetsFlameImages.game_BG_game,
              fit: BoxFit.cover,
            ),
            PageView(
              pageSnapping: true,
              controller: pageController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index + 1;
                });
              },
              children: questionsList.map((question) {
                return QuizQuestion(
                    quizQuestion: question,
                    onTap: (isCorrect) async {
                      if (isCorrect) {
                        await showPopUpFact(question.id, context);
                        AppStorage.answeredQuestions.val.add(question.id);
                        correctAnswers++;
                      }
                      if (currentIndex == questionsList.length) {
                        Navigator.pushReplacementNamed(context, Routes.end,
                            arguments: {
                              'correctAnswers': correctAnswers,
                              'totalQuestions': questionsList.length
                            });
                        return;
                      }
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    });
              }).toList(),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 60,
                      width: 60,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AssetsFlameImages.game_button_check,
                          height: 60,
                        ),
                        Text(
                          '$currentIndex \\ ${questionsList.length.toString()}',
                          textAlign: TextAlign.center,
                        ).formated(size: 32, color: Colors.green)
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        print('object');
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        AssetsFlameImages.game_button_home,
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
