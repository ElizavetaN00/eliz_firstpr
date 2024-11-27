import 'package:color_puzzle/app/module/game/routes/settings_route.dart';
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
  var colorId = 0;
  newGame() async {
    router.pop();
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
          // 'tutorial': TutorialRoute(),
          'game': Route(GamePage.new, maintainState: false),
          'game_over': GameOverRoute(value: true),
        },
        initialRoute: 'menu_loading',
      ),
    );
  }
}
