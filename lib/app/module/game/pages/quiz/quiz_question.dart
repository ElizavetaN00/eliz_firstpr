import 'package:flutter/material.dart';
import 'package:game/app/module/game/pages/quiz/quiz_question_model.dart';
import 'package:game/generated/assets_flame_images.dart';

class QuizQuestion extends StatefulWidget {
  const QuizQuestion({super.key, required this.quizQuestion, required this.onTap});
  final QuizQuestionModel quizQuestion;
  final Function() onTap;

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.quizQuestion.question).formated(size: 32),
          const SizedBox(height: 20),
          SelectItemsWidget(
            correctAnswer: widget.quizQuestion.answer,
            items: widget.quizQuestion.options,
            onTapCorrect: () {
              widget.onTap.call();
            },
            onTapWrong: () {
              widget.onTap.call();
            },
          )
        ],
      ),
    );
  }
}

extension TextFormated on Text {
  formated({double? size, Color? color}) {
    return Text(
      data!,
      style: TextStyle(
        fontFamily: 'Koulen',
        color: color ?? Colors.white,
        fontSize: size,
      ),
    );
  }
}

class SelectItemsWidget extends StatefulWidget {
  const SelectItemsWidget({
    super.key,
    required this.items,
    required this.correctAnswer,
    required this.onTapWrong,
    required this.onTapCorrect,
  });
  final List<String> items;
  final int correctAnswer;
  final Function() onTapWrong;
  final Function() onTapCorrect;
  @override
  State<SelectItemsWidget> createState() => _SelectItemsWidgetState();
}

class _SelectItemsWidgetState extends State<SelectItemsWidget> {
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: widget.items.map((item) {
        return InkWell(
          onTap: () {
            setState(() {
              currentIndex = widget.items.indexOf(item);
            });
            if (widget.correctAnswer == widget.items.indexOf(item)) {
              widget.onTapCorrect.call();
            } else {
              widget.onTapWrong.call();
            }
          },
          child: Flexible(
            child: QuestionItem(
              isActive: currentIndex == widget.items.indexOf(item),
              text: item.toString(),
              isCorrect: widget.correctAnswer == widget.items.indexOf(item),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class QuestionItem extends StatelessWidget {
  const QuestionItem({super.key, required this.isActive, required this.text, required this.isCorrect});
  final bool isActive;
  final String text;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          isActive
              ? isCorrect
                  ? Image.asset(AssetsFlameImages.game_button_reply_marked, width: 50, height: 50)
                  : Image.asset(AssetsFlameImages.game_button_wrong_answer, width: 50, height: 50)
              : Image.asset(AssetsFlameImages.game_button_reply, width: 50, height: 50),
          const SizedBox(width: 10),
          Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
              ).formated(size: 30, color: isActive ? Colors.white : Colors.white54))
        ],
      ),
    );
  }
}
