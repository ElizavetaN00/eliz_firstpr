import 'dart:ui';

import 'package:color_puzzle/app/module/game/components/background_component.dart';
import 'package:color_puzzle/data/storage/storage.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

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
  late final Image closeImage;
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
    closeImage = Flame.images.fromCache('close-button.png');

    musicButton = SpriteWithTap(
      anchor: Anchor.topCenter,
      size: logicalSize(840, 164),
      position: logicalSize(960, 349),
      sprite: Sprite(
        isMusicOn ? musicOn : musicOff,
      ),
      onTap: () async {
        isMusicOn = !isMusicOn;
        if (isMusicOn) {
          await FlameAudio.bgm.resume();
        } else {
          await FlameAudio.bgm.pause();
        }
        AppStorage.musicEnabled.val = isMusicOn;
      },
    );

    soundButton = SpriteWithTap(
      anchor: Anchor.topCenter,
      size: logicalSize(840, 164),
      position: logicalSize(960, 553),
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
      size: logicalSize(840, 164),
      position: logicalSize(960, 757),
      sprite: Sprite(
        tutotialImage,
      ),
      onTap: () {
        game.router.pushReplacementNamed('tutorial');
      },
    );

    final closeButton = SpriteWithTap(
      anchor: Anchor.topRight,
      size: logicalSize(52, 52),
      position: logicalSize(1390, 150),
      sprite: Sprite(
        closeImage,
      ),
      onTap: () {
        game.router.pop();
      },
    );

    popUpComponent = SpriteComponent(
      anchor: Anchor.center,
      size: logicalSize(1400, 1300),
      position: logicalSize(960, 540),
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
      closeButton,
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
  bool containsLocalPoint(Vector2 point) => true;
}
