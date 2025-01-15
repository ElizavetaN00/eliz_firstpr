import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../generated/assets_flame_images.dart';
import '../widgets/back_button/back_button.dart';

class MyMixtures extends StatelessWidget {
  const MyMixtures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(fit: StackFit.expand, children: [
      Image.asset(
        AssetsFlameImages.bg_my_mixtures_books_and_teapot,
        fit: BoxFit.cover,
      ),
      const BaseBackButton(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 180),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyMixturesCreateNew()));
                },
                child: Image.asset(
                  AssetsFlameImages.game_pill_new_button,
                )),
          ],
        ),
      )
    ])));
  }
}

class MyMixturesCreateNew extends StatefulWidget {
  const MyMixturesCreateNew({super.key});

  @override
  State<MyMixturesCreateNew> createState() => _MyMixturesCreateNewState();
}

class _MyMixturesCreateNewState extends State<MyMixturesCreateNew> {
  var textController = TextEditingController();

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
            //make textfield without border with placeholder = "Tap here to change the name", white font color, font size 24
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
            const SizedBox(height: 20),
            //make textfield without border with placeholder = "Tap here to change the description", white font color, font size 24
            InkWell(
                onTap: () {},
                child: Image.asset(
                  AssetsFlameImages.game_addition,
                )),
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
