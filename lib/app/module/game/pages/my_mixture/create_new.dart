import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/app/module/game/pages/cards/cards_model.dart';

import '../../../../../data/storage/storage.dart';
import '../../../../../generated/assets_flame_images.dart';
import '../../widgets/back_button/back_button.dart';
import '../cards/cards_view.dart';
import 'my_mixtures_model.dart';

class MyMixturesCreateNew extends StatefulWidget {
  const MyMixturesCreateNew({super.key, this.myMixturesModel});
  final MyMixturesModel? myMixturesModel;

  @override
  State<MyMixturesCreateNew> createState() => _MyMixturesCreateNewState();
}

class _MyMixturesCreateNewState extends State<MyMixturesCreateNew> {
  var textController = TextEditingController();
  var cardsList = <CardModel>[];

  @override
  void initState() {
    if (widget.myMixturesModel != null) {
      textController.text = widget.myMixturesModel!.name;
      cardsList = widget.myMixturesModel!.cardsList;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Stack(fit: StackFit.expand, children: [
          Image.asset(
            AssetsFlameImages.bg_createnew,
            fit: BoxFit.cover,
          ),
          const BaseBackButton(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                TextFormField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  controller: textController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Tap here to change the name'.toUpperCase(),
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Cuprum',
                        fontWeight: FontWeight.w700),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Cuprum',
                      fontWeight: FontWeight.w700),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cardsList.length,
                    itemBuilder: (context, index) {
                      return CardWidget(cardModel: cardsList[index]);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible:
                      cardsList.length < 4 && widget.myMixturesModel == null,
                  child: InkWell(
                      onTap: () async {
                        if (cardsList.length >= 4) {
                          return;
                        }
                        var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      body: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.asset(
                                            AssetsFlameImages.bg_createnew,
                                            fit: BoxFit.cover,
                                          ),
                                          const BaseBackButton(),
                                          const CardsView(
                                            forMixture: true,
                                          ),
                                        ],
                                      ),
                                    )));

                        if (result != null) {
                          setState(() {
                            if (cardsList.contains(result)) {
                              cardsList.remove(result);
                              return;
                            }
                            cardsList.add(result);
                          });
                        }
                      },
                      child: Image.asset(
                        AssetsFlameImages.game_addition,
                      )),
                ),
                Visibility(
                  visible: cardsList.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: InkWell(
                      onTap: () {
                        if (AppStorage.soundEnabled.val) {
                          FlameAudio.play('save_tie.wav', volume: 0.7);
                        }
                        if (widget.myMixturesModel != null) {
                          widget.myMixturesModel!.removeFromStorage();
                        }
                        AppStorage.myMixtures.val = [
                          ...AppStorage.myMixtures.val,
                          MyMixturesModel(
                            name: textController.text,
                            cardsList: cardsList,
                          ).toStorage()
                        ];

                        Navigator.pop(
                            context,
                            MyMixturesModel(
                              name: textController.text,
                              cardsList: cardsList,
                            ));
                      },
                      child: Image.asset(
                        AssetsFlameImages.game_save,
                        height: 100,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ])));
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
