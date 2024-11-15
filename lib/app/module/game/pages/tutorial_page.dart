import 'dart:ui';

import 'package:color_puzzle/app/module/game/components/background_component.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import '../components/logical_size_component.dart';
import '../components/sprite_with_tap.dart';
import '../game.dart';

class TutorialPage extends LogicalSizeComponent<AppGame> with TapCallbacks {
  late final Image tutorialPopUp;
  late final SpriteComponent popUpComponent;
  late final Image closeImage;
  @override
  Future<void> onLoad() async {
    tutorialPopUp = Flame.images.fromCache('tutorial_big.png');
    closeImage = Flame.images.fromCache('close-button.png');

    popUpComponent = SpriteComponent(
      anchor: Anchor.center,
      size: LogicalSize.logicalSize(1600, 1280),
      position: LogicalSize.logicalSize(960, 540),
      sprite: Sprite(
        tutorialPopUp,
      ),
    );
    final closeButton = SpriteWithTap(
      anchor: Anchor.topRight,
      size: LogicalSize.logicalSize(52, 52),
      position: LogicalSize.logicalSize(1550, 150),
      sprite: Sprite(
        closeImage,
      ),
      onTap: () {
        game.router.pop();
      },
    );

    final background = Background(const Color(0x99000000));

    addAll([
      background,
      popUpComponent,
      closeButton,
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
