import 'package:color_puzzle/app/module/game/components/my_sprite_component/my_sprite_component.dart';
import 'package:color_puzzle/app/module/game/components/my_sprite_component/tap_original_size.dart';
import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../../../../data/storage/storage.dart';
import '../components/logical_size_component.dart';
import '../game.dart';

class GameOverPage extends PositionComponent
    with HasGameReference<AppGame>, TapCallbacks {
  factory GameOverPage.draw() =>
      GameOverPage(img: AssetsFlameImages.Frame_17, sound: 'draw screen.wav');
  factory GameOverPage.victory() => GameOverPage(
      img: AssetsFlameImages.Frame_18, sound: 'victory screen.wav');
  factory GameOverPage.loss() =>
      GameOverPage(img: AssetsFlameImages.Frame_19, sound: 'lose screen.wav');

  String img;

  GameOverPage(
      {this.img = AssetsFlameImages.Frame_17,
      super.size,
      this.sound = 'draw screen.wav'});
  final String sound;
  bool isOnSound = AppStorage.soundEnabled.val;
  @override
  void onMount() {
    if (isOnSound) {
      FlameAudio.play(sound);
    }
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    final gameOverPopUp = await game.images.load(img);
    final restart = await game.images.load(AssetsFlameImages.Frame_20);

    final restartComponent = OriginalSpriteWithTap(
      sprite: Sprite(restart),
      onTap: () {
        game.newGame();
      },
      position: LogicalSize.logicalSize(200, 1500),
    );
    var userScore = game.userScore;
    var dealerScore = game.dealerScore;

    addAll([
      OriginalSizeLogicSpriteComponent(
        children: [],
        sprite: Sprite(gameOverPopUp),
        position: game.canvasSize / 2,
        anchor: Anchor.center,
      ),
      TextComponent(
        text: userScore.toString(),
        anchor: Anchor.center,
        position: Vector2(
            LogicalSize.logicalWidth(530), LogicalSize.logicalHight(953 + 200)),
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 70, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      TextComponent(
        text: dealerScore.toString(),
        anchor: Anchor.center,
        position: Vector2(
            LogicalSize.logicalWidth(530), LogicalSize.logicalHight(930)),
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 70, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      restartComponent,
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
