import 'package:flame/game.dart';
import 'package:flame/src/components/core/component.dart';

import '../pages/game_over_page.dart';

class GameOverRoute extends ValueRoute<bool> {
  GameOverRoute({required super.value, super.transparent = true});

  @override
  void onPush(Route? previousRoute) {
    previousRoute!.stopTime();
  }

  @override
  void onPop(Route nextRoute) {
    nextRoute
      ..resumeTime()
      ..removeRenderEffect();
  }

  @override
  Component build() {
    return GameOverPage();
  }
}
