import 'package:flutter/material.dart';

import '../../../../../generated/assets_flame_images.dart';
import '../../widgets/back_button/back_button.dart';
import 'create_new.dart';

class MyMixturesView extends StatelessWidget {
  const MyMixturesView({super.key});

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
