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
              AssetsFlameImages.bg_magical_library_bookshelf_gemstones,
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
                          child: Image.asset(AssetsFlameImages.game_herbal_tea_collection)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.myMixtures);
                          },
                          child: Image.asset(AssetsFlameImages.game_mixtured_potions)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.achivments);
                          },
                          child: Image.asset(AssetsFlameImages.game_achievement_icons)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settings);
                          },
                          child: Image.asset(AssetsFlameImages.game_settings_gear)),
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
