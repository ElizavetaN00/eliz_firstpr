import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../components/logical_size_component.dart';
import '../components/sprite_with_tap.dart';
import '../game.dart';

class GameOverPage extends Component with HasGameReference<AppGame> {
  @override
  Future<void> onLoad() async {
    final gameOverPopUp = await game.images.load(AssetsFlameImages.Frame_8);
    final backToMenu = await game.images.load(AssetsFlameImages.Group);
    final restart = await game.images.load(AssetsFlameImages.Btn);

    final backToMenuComponent = SpriteWithTap(
      sprite: Sprite(backToMenu),
      onTap: () {
        game.router.pop();
        game.router.pop();
      },
      position: LogicalSize.logicalSize(580, 716),
      size: LogicalSize.logicalSize(480, 164),
    );

    final restartComponent = SpriteWithTap(
      sprite: Sprite(restart),
      onTap: () {
        game.newGame();
      },
      position: LogicalSize.logicalSize(200, 1233),
      size: LogicalSize.logicalSize(678, 224),
    );
    final score = game.score;

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
