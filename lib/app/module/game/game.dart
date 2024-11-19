import 'package:color_puzzle/app/module/game/routes/settings_route.dart';
import 'package:color_puzzle/app/module/game/routes/tutorial_route.dart';
import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' as m;

import 'components/logical_size_component.dart';
import 'routes/game_over_route.dart';
import 'pages/game_page.dart';
import 'pages/menu_loading_page.dart';
import 'pages/menu_page.dart';

class AppGame extends FlameGame with HasCollisionDetection {
  late final RouterComponent router;
  int score = 0;

  newGame() async {
    score = 0;
    router.popUntilNamed('menu');
    await Future.delayed(const Duration(milliseconds: 100));
    router.pushNamed('game');
  }

  @override
  void onGameResize(Vector2 size) {
    LogicalSize.setSize(size);
    super.onGameResize(size);
  }

  @override
  Future<void> onLoad() async {
    for (final image in AssetsFlameImages.all) {
      await Flame.images.load(image);
    }

    LogicalSize.setSize(size);

    add(
      router = RouterComponent(
        routes: {
          'menu_loading': Route(MenuLoadingPage.new),
          'menu': Route(MenuPage.new),
          'settings': SettingsRoute(),
          'tutorial': TutorialRoute(),
          'game': Route(GamePage.new, maintainState: true),
          'game_over': GameOverRoute(),
        },
        initialRoute: 'menu_loading',
      ),
    );
  }
}
