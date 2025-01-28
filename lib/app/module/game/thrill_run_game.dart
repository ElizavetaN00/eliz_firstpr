import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:game/generated/assets_flame_images.dart';

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
    await Flame.images.loadAll(AssetsFlameImages.all);

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
