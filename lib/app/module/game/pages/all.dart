import 'package:flutter/material.dart';

import '../../../../generated/assets_flame_images.dart';
import '../widgets/back_button/back_button.dart';
import 'cards/cards_view.dart';

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(
            AssetsFlameImages.bg_book_and_cups_of_magic_teas_in_a_mysterious_setting,
            fit: BoxFit.cover,
          ),
          const BaseBackButton(),
          const CardsView(),
        ]),
      ),
    );
  }
}
