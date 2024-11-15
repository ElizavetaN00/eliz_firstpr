import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../components/logical_size_component.dart';
import '../components/sprite_with_tap.dart';
import '../game.dart';

class GameOverPage extends Component with HasGameReference<AppGame> {
  @override
  Future<void> onLoad() async {
    final gameOverPopUp = await game.images.load('game_over.png');
    final backToMenu = await game.images.load('Btn-Back to menu 1.png');
    final restart = await game.images.load('Btn-Restart 1.png');

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
        game.router.pop();
        game.newGame();
      },
      position: LogicalSize.logicalSize(1100, 716),
      size: LogicalSize.logicalSize(480, 164),
    );
    final score = game.score;
    final scoreComponent = TextComponent(
      text: score.toString(),
      anchor: Anchor.topCenter,
      position: LogicalSize.logicalSize(LogicalSize.logicalXCenter, 400),
      textRenderer: TextPaint(
          style: const TextStyle(
        fontSize: 70,
        color: Color.fromRGBO(255, 10, 112, 1),
        fontFamily: 'BungeeShade',
      )),
    );
    addAll([
      SpriteComponent(
          sprite: Sprite(gameOverPopUp),
          position: game.canvasSize / 2,
          anchor: Anchor.center,
          size: LogicalSize.logicalSize(1500, 1200)),
      scoreComponent,
      backToMenuComponent,
      restartComponent,
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
