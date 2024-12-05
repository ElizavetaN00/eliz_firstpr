import 'package:flutter/material.dart';
import 'package:game/generated/assets_flame_images.dart';

import '../../../app.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AssetsFlameImages.menu_BG_manu,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.game);
                          },
                          child: Image.asset(AssetsFlameImages.menu_button_quiz)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.gallery);
                          },
                          child: Image.asset(AssetsFlameImages.menu_button_Gallery_of_facts)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.about);
                          },
                          child: Image.asset(AssetsFlameImages.menu_button_About_the_application)),
                      const SizedBox(height: 100),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
