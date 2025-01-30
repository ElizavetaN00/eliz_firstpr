import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:game/app/module/game/pages/fly.dart';
import 'package:game/generated/assets_flame_images.dart';

import 'components/logical_size_component.dart';
import 'pages/game_over_route.dart';
import 'pages/run.dart';
import 'pages/menu_loading_page.dart';

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
          'game_over': GameOverRoute(),
          'run': Route(Run.new),
          'fly': Route(Fly.new),
        },
        initialRoute: 'menu_loading',
      ),
    );
  }
}
