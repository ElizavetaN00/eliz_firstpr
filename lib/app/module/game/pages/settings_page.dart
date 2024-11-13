import 'dart:ui';

import 'package:color_puzzle/app/module/game/components/background_component.dart';
import 'package:color_puzzle/data/storage/storage.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import '../components/logical_size_component.dart';
import '../components/sprite_with_tap.dart';
import '../game.dart';

class SettingsPage extends LogicalSizeComponent<AppGame> with TapCallbacks {
  bool isMusicOn = AppStorage.musicEnabled.val;
  bool isSoundOn = AppStorage.soundEnabled.val;

  late final Image musicOn;
  late final Image musicOff;
  late final Image soundOn;
  late final Image soundOff;
  late final Image settingsPopUp;
  late final Image tutotialImage;
  late final SpriteWithTap musicButton;
  late final SpriteWithTap soundButton;
  late final SpriteComponent popUpComponent;
  @override
  Future<void> onLoad() async {
    settingsPopUp = Flame.images.fromCache('Pop-up (1).png');
    musicOn = Flame.images.fromCache('music_on.png');
    musicOff = Flame.images.fromCache('music_off.png');
    soundOn = Flame.images.fromCache('sound_on.png');
    soundOff = Flame.images.fromCache('sound_off.png');
    tutotialImage = Flame.images.fromCache('tutorial.png');

    musicButton = SpriteWithTap(
      anchor: Anchor.topCenter,
      size: LogicalSize.logicalSize(840, 164),
      position: LogicalSize.logicalSize(960, 349),
      sprite: Sprite(
        isMusicOn ? musicOn : musicOff,
      ),
      onTap: () {
        isMusicOn = !isMusicOn;
        AppStorage.musicEnabled.val = isMusicOn;
      },
    );

    soundButton = SpriteWithTap(
      anchor: Anchor.topCenter,
      size: LogicalSize.logicalSize(840, 164),
      position: LogicalSize.logicalSize(960, 553),
      sprite: Sprite(
        isSoundOn ? soundOn : soundOff,
      ),
      onTap: () {
        isSoundOn = !isSoundOn;
        AppStorage.soundEnabled.val = isSoundOn;
      },
    );

    final tutorialButton = SpriteWithTap(
      anchor: Anchor.topCenter,
      size: LogicalSize.logicalSize(840, 164),
      position: LogicalSize.logicalSize(960, 757),
      sprite: Sprite(
        tutotialImage,
      ),
      onTap: () {
        print('tutorial');
      },
    );

    popUpComponent = SpriteComponent(
      anchor: Anchor.center,
      size: LogicalSize.logicalSize(1340, 1280),
      position: LogicalSize.logicalSize(960, 540),
      sprite: Sprite(
        settingsPopUp,
      ),
    );

    final background = Background(const Color(0x99000000));

    addAll([
      background,
      popUpComponent,
      soundButton,
      musicButton,
      tutorialButton,
    ]);
  }

  @override
  void update(double dt) {
    musicButton.sprite = Sprite(
      isMusicOn ? musicOn : musicOff,
    );
    soundButton.sprite = Sprite(
      isSoundOn ? soundOn : soundOff,
    );
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!popUpComponent.containsPoint(event.canvasPosition)) {
      game.router.pop();
    }
    super.onTapDown(event);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
