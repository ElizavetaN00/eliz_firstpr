import 'package:flutter/material.dart';
import 'package:game/app/module/game/pages/quiz/quiz_question.dart';
import 'package:game/app/module/game/pages/quiz/quiz_question_model.dart';
import 'package:game/data/storage/storage.dart';
import 'package:game/generated/assets_flame_images.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<QuizQuestionModel> questionsList = [];
  int currentIndex = 1;
  PageController pageController = PageController();

  @override
  void initState() {
    var listIndexOfansweredQuestions = [];
    for (var element in AppStorage.answeredQuestions.val) {
      listIndexOfansweredQuestions.add(element);
    }
    questionsList = listQuestions;
    questionsList.removeWhere((element) => listIndexOfansweredQuestions.contains(questionsList.indexOf(element)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: () => pageController.nextPage(duration: const Duration(), curve: Curves.bounceIn),
                );
              }).toList(),
            ),
            Padding(
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
          ],
        ),
      ),
    );
  }
}
