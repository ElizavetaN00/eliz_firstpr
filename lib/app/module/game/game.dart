import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import '../../../data/app_resources.dart';
import 'components/logical_size_component.dart';
import 'pages/game_over_route.dart';
import 'pages/level_page.dart';
import 'pages/menu_loading_page.dart';
import 'pages/menu_page.dart';

class AppGame extends FlameGame with HasCollisionDetection {
  late final RouterComponent router;

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
          'game': Route(GamePage.new, maintainState: false),
          'game_over': GameOverRoute(),
        },
        initialRoute: 'menu_loading',
      ),
    );
  }
}
