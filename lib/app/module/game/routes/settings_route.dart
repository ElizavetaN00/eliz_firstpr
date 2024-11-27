import 'package:flame/game.dart';
import 'package:flame/src/components/core/component.dart';

import '../pages/settings_page.dart';

class SettingsRoute extends ValueRoute {
  SettingsRoute()
      : super(
          value: true,
          transparent: true,
        );

  @override
  void onPush(Route? previousRoute) {
    previousRoute!.stopTime();
  }

  @override
  void onPop(Route nextRoute) {
    nextRoute..resumeTime();
    //   ..removeRenderEffect();
  }

  @override
  Component build() {
    return SettingsPage();
  }
}
