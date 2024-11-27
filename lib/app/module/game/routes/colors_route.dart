import 'package:flame/components.dart';
import 'package:flame/game.dart';

import '../pages/color.dart';

class ColorRoute extends ValueRoute<bool> {
  ColorRoute({required super.value, super.transparent = true});

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
    return ColorPage();
  }
}
