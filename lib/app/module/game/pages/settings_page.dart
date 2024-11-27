import 'dart:ui';

import 'package:color_puzzle/app/module/game/components/background_component.dart';
import 'package:color_puzzle/app/module/game/components/my_sprite_component/my_sprite_component.dart';
import 'package:color_puzzle/app/module/game/routes/colors_route.dart';
import 'package:color_puzzle/data/storage/storage.dart';
import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

import '../components/logical_size_component.dart';
import '../components/sprite_with_tap.dart';
import '../components/tap_position/tap_position.dart';
import '../game.dart';

class SettingsPage extends LogicalSizeComponent<AppGame> with TapCallbacks {
  bool isMusicOn = AppStorage.musicEnabled.val;
  bool isSoundOn = AppStorage.soundEnabled.val;

  late final Image musicOn;
  late final Image musicOff;
  late final Image soundOn;
  late final Image soundOff;
  late final Image settingsPopUp;
  late final Image tutorialImage;
  late final Image closeImage;
  late final SpriteWithTap musicButton;
  late final SpriteWithTap soundButton;
  late final SpriteComponent popUpComponent;
  @override
  Future<void> onLoad() async {
    settingsPopUp = Flame.images.fromCache(AssetsFlameImages.Frame_40);
    musicOn = Flame.images.fromCache(AssetsFlameImages.Frame_11);
    musicOff = Flame.images.fromCache(AssetsFlameImages.Frame_11_1);
    soundOn = Flame.images.fromCache(AssetsFlameImages.Frame_10_3);
    soundOff = Flame.images.fromCache(AssetsFlameImages.Frame_10_2);
    closeImage = Flame.images.fromCache(AssetsFlameImages.Frame_2);
    var colorImage = Flame.images.fromCache(AssetsFlameImages.Frame_12);

    var colorComponent = SpriteWithTap(
      anchor: Anchor.topLeft,
      size: logicalSize(676, 203),
      position: logicalSize(201, 855),
      sprite: Sprite(colorImage),
      onTap: () async {
        game.router.pushAndWait(ColorRoute(value: true));
      },
    );

    musicButton = SpriteWithTap(
      anchor: Anchor.topLeft,
      size: logicalSize(676, 203),
      position: logicalSize(201, 1300),
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
      anchor: Anchor.topLeft,
      size: logicalSize(676, 203),
      position: logicalSize(201, 1078),
      sprite: Sprite(
        isSoundOn ? soundOn : soundOff,
      ),
      onTap: () {
        isSoundOn = !isSoundOn;
        AppStorage.soundEnabled.val = isSoundOn;
      },
    );

    final closeButton = TapPositionComponent(
      anchor: Anchor.topRight,
      size: logicalSize(140, 140),
      position: logicalSize(1000, 400),
      onTap: () {
        game.router.pop();
      },
    );

    popUpComponent = OriginalSizeLogicSpriteComponent(
      anchor: Anchor.topCenter,
      position: logicalSize(539, 400),
      sprite: Sprite(
        settingsPopUp,
      ),
    );

    final background = Background(const Color(0x99000000));

    addAll([
      background,
      popUpComponent,
      colorComponent,
      soundButton,
      musicButton,
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
