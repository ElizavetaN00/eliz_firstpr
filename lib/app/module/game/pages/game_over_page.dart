import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/app/module/game/components/background_component.dart';
import 'package:game/generated/assets_flame_images.dart';

import '../../../../data/storage/storage.dart';
import '../components/logical_size_component.dart';
import '../components/sprite_with_tap.dart';
import '../thrill_run_game.dart';

class GameOverPage extends Component with HasGameReference<ThrillRunGame> {
  @override
  Future<void> onLoad() async {
    final overFrame = await game.images
        .load(AssetsFlameImages.game_pop_up_game_over_BG_pop_up_game_over);
    final scoreComponent = TextComponent(
      text: AppStorage.lastScore.val.toString(),
      anchor: Anchor.topCenter,
      position: LogicalSize.logicalSize(LogicalSize.logicalXCenter, 400),
      textRenderer: TextPaint(
          style: const TextStyle(
        fontSize: 56,
        fontFamily: 'Retro Gaming',
        color: Color(0xFFA60022),
      )),
    );
    final playAgain = await game.images.load('pop_up/play_again.png');
    final playAgainSprite = SpriteWithTap(
      anchor: Anchor.topCenter,
      size: LogicalSize.logicalSize(538, 110),
      position: LogicalSize.logicalSize(LogicalSize.logicalXCenter, 710),
      sprite: Sprite(
        playAgain,
      ),
      onTap: () {
        game.router.pop();
        game.router.pushReplacementNamed('select_level');
      },
    );
    addAll([
      Background(Colors.black),
      SpriteComponent(
        sprite: Sprite(overFrame),
        position: game.canvasSize,
        anchor: Anchor.center,
      ),
      scoreComponent,
      playAgainSprite,
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
