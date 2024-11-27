import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../components/logical_size_component.dart';
import '../components/sprite_with_tap.dart';
import '../game.dart';

class GameOverPage extends PositionComponent
    with HasGameReference<AppGame>, TapCallbacks {
  factory GameOverPage.draw() => GameOverPage(img: AssetsFlameImages.Frame_17);
  factory GameOverPage.victory() =>
      GameOverPage(img: AssetsFlameImages.Frame_18);
  factory GameOverPage.loss() => GameOverPage(img: AssetsFlameImages.Frame_19);

  String img;

  GameOverPage({this.img = AssetsFlameImages.Frame_17, super.size});

  @override
  Future<void> onLoad() async {
    final gameOverPopUp = await game.images.load(img);
    final restart = await game.images.load(AssetsFlameImages.Frame_20);

    final restartComponent = SpriteWithTap(
      sprite: Sprite(restart),
      onTap: () {
        game.newGame();
      },
      position: LogicalSize.logicalSize(200, 1233),
      size: LogicalSize.logicalSize(678, 224),
    );
    const score = 0;

    addAll([
      SpriteComponent(
          children: [],
          sprite: Sprite(gameOverPopUp),
          position: game.canvasSize / 2,
          anchor: Anchor.center,
          size: LogicalSize.logicalSize(921, 1073)),
      TextComponent(
        text: score.toString(),
        anchor: Anchor.center,
        position: Vector2(
            LogicalSize.logicalWidth(530), LogicalSize.logicalHight(953 + 100)),
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 70, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      restartComponent,
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
