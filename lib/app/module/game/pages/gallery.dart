import 'package:flutter/material.dart';
import 'package:game/app/module/game/pages/quiz/quiz_question.dart';
import 'package:game/data/storage/storage.dart';

import '../../../../generated/assets_flame_images.dart';
import 'gallery/pop_up_gallery.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    var openedFacts = AppStorage.answeredQuestions.val;
    print(openedFacts);
    return Scaffold(
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AssetsFlameImages.game_BG_game,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 60,
                      width: 60,
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
                Text('FACTS').formated(size: 100),
                Expanded(
                  child: GridView(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    children: Facts().factsId.map((index) {
                      return SizedBox(
                        child: InkWell(
                          onTap: () {
                            if (!openedFacts.contains(index)) {
                              return;
                            }
                            showPopUpFact(index, context);
                          },
                          child: SizedBox(
                            child: Image.asset(
                              openedFacts.contains(index)
                                  ? Facts().getOpenFact(index)
                                  : Facts().getLockFacts(index),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

showPopUpFact(int index, BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(Facts().getPopUpFact(index)),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        height: 60,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            AssetsFlameImages
                                .About_the_application_button_close,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )));
}
