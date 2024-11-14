import 'dart:math';
import 'dart:ui';

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
  late final List<m.Color> holeColorList;

  List<Color> generateHoleList() {
    final random = Random();

    final blueColors = List<Color>.generate(5, (index) {
      return ColorCrystal.baseColors[0];
    });

    final redColors = List<Color>.generate(5, (index) {
      return ColorCrystal.baseColors[1];
    });

    final yellowColors = List<Color>.generate(5, (index) {
      return ColorCrystal.baseColors[2];
    });

    final list = blueColors + redColors + yellowColors;

    // Функция для проверки условия
    bool isValidShuffle(List<Color> arr) {
      int count = 1;
      for (int i = 1; i < arr.length; i++) {
        if (arr[i] == arr[i - 1]) {
          count++;
          if (count > 3) {
            return false; // Проверка на 4 одинаковых подряд
          }
        } else {
          count = 1;
        }
      }
      return true;
    }

    // Перемешиваем, пока не будет удовлетворено условие
    do {
      list.shuffle(random);
    } while (!isValidShuffle(list));

    return list;
  }

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
    holeColorList = generateHoleList();
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
