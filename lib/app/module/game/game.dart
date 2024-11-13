import 'package:color_puzzle/app/module/game/routes/settings_route.dart';
import 'package:color_puzzle/app/module/game/routes/tutorial_route.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' as m;

import '../../../data/app_resources.dart';
import 'components/hextile/color_crystal.dart';
import 'components/logical_size_component.dart';
import 'routes/game_over_route.dart';
import 'pages/level_page.dart';
import 'pages/menu_loading_page.dart';
import 'pages/menu_page.dart';

class AppGame extends FlameGame with HasCollisionDetection {
  late final RouterComponent router;

  m.Color get currentColor => holeColorList.last;
  List<m.Color> holeColorList = ColorCrystal.baseColors;

  nextColor() {
    holeColorList.insert(0, holeColorList.last);
    holeColorList.removeLast();
  }

  @override
  void onGameResize(Vector2 size) {
    LogicalSize.setSize(size);
    super.onGameResize(size);
  }

  @override
  Future<void> onLoad() async {
    for (final image in AppResources.flameImages) {
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
          'game': Route(GamePage.new, maintainState: false),
          'game_over': GameOverRoute(),
        },
        initialRoute: 'menu_loading',
      ),
    );
  }
}
