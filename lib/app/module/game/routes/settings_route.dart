import 'package:flame/game.dart';

import '../pages/settings_page.dart';

class SettingsRoute extends Route {
  SettingsRoute()
      : super(SettingsPage.new, transparent: true, maintainState: false);

  @override
  void onPush(Route? previousRoute) {
    // previousRoute!.stopTime();
  }

  @override
  void onPop(Route nextRoute) {
    // nextRoute
    //   ..resumeTime()
    //   ..removeRenderEffect();
  }
}
