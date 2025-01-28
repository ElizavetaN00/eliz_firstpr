import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'components/logical_size_component.dart';
import 'pages/game_over_route.dart';
import 'pages/level_page.dart';
import 'pages/menu_loading_page.dart';
import 'pages/menu_page.dart';
import 'pages/select_level_page.dart';

class ThrillRunGame extends FlameGame with HasCollisionDetection {
  late final RouterComponent router;

  @override
  void onGameResize(Vector2 size) {
    LogicalSize.setSize(size);
    super.onGameResize(size);
  }

  @override
  Future<void> onLoad() async {
    await Flame.images.load('menu/menu_bg.png');
    await Flame.images.load('menu/logo.png');
    await Flame.images.load('preload/spinner.png');
    await Flame.images.load('menu/select_level.png');
    await Flame.images.load('menu/exit.png');
    await Flame.images.load('menu/sond_on.png');
    await Flame.images.load('menu/sond_on-1.png');
    await Flame.images.load('menu/music_off.png');
    await Flame.images.load('menu/sond_off.png');
    await Flame.images.load('game/bg1.png');
    await Flame.images.load('game/bg2.png');
    await Flame.images.load('game/bg3.png');
    await Flame.images.load('menu/slect_level/bg.png');
    await Flame.images.load('menu/slect_level/frame.png');
    await Flame.images.load('menu/slect_level/select.png');
    await Flame.images.load('menu/slect_level/1.png');
    await Flame.images.load('menu/slect_level/2.png');
    await Flame.images.load('menu/slect_level/3.png');
    await Flame.images.load('menu/slect_level/50_to_open.png');
    await Flame.images.load('menu/slect_level/100_to_open.png');
    await Flame.images.load('game/miles.png');
    await Flame.images.load('game/score_frame.png');
    await Flame.images.load('pop_up/frame.png');

    LogicalSize.setSize(size);

    add(
      router = RouterComponent(
        routes: {
          'menu_loading': Route(MenuLoadingPage.new),
          'menu': Route(MenuPage.new),
          'select_level': Route(SelectLevelPage.new, maintainState: false),
          'level1': Route(LevelPage.level1, maintainState: false),
          'level2': Route(LevelPage.level2, maintainState: false),
          'level3': Route(LevelPage.level3, maintainState: false),
          'game_over': GameOverRoute(),
        },
        initialRoute: 'menu_loading',
      ),
    );
  }
}
