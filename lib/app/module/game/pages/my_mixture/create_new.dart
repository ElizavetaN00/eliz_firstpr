import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/app/module/game/pages/cards/cards_model.dart';

import '../../../../../generated/assets_flame_images.dart';
import '../../widgets/back_button/back_button.dart';
import '../cards/cards_view.dart';

class MyMixturesCreateNew extends StatefulWidget {
  const MyMixturesCreateNew({super.key});

  @override
  State<MyMixturesCreateNew> createState() => _MyMixturesCreateNewState();
}

class _MyMixturesCreateNewState extends State<MyMixturesCreateNew> {
  var textController = TextEditingController();
  var cardsList = <CardModel>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: Colors.white, fontSize: 40, fontFamily: 'Cuprum', fontWeight: FontWeight.w700),
                alignLabelWithHint: true,
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: Colors.white, fontSize: 40, fontFamily: 'Cuprum', fontWeight: FontWeight.w700),
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
            InkWell(
                onTap: () async {
                  var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                body: Stack(
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
            Visibility(
              visible: cardsList.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: InkWell(
                  onTap: () {},
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
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
