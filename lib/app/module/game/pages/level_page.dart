import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import '../../../../data/storage/storage.dart';
import '../components/player/player.dart';
import '../components/logical_size_component.dart';
import 'dart:math' as math;

import '../components/sprite_with_tap.dart';
import '../game.dart';

class GamePage extends PositionComponent with TapCallbacks {
  late final PlayerComponent player;
  AppGame get game => findGame()! as AppGame;

  @override
  Future<void> onLoad() async {
    final imageBg = Flame.images.fromCache('Background 2.png');
    final settingImage = Flame.images.fromCache('Btn-Setting.png');
    final restartImage = Flame.images.fromCache('Btn-Restart.png');
    size = game.canvasSize;

    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      SpriteWithTap(
        anchor: Anchor.topLeft,
        size: LogicalSize.logicalSize(173, 153),
        position: Vector2(40, 40),
        sprite: Sprite(
          settingImage,
        ),
        onTap: () {
          game.router.pushNamed('menu');
        },
      ),
      SpriteWithTap(
        anchor: Anchor.topLeft,
        size: LogicalSize.logicalSize(173, 153),
        position: Vector2(40, 253),
        sprite: Sprite(
          restartImage,
        ),
        onTap: () {
          game.router.pushNamed('game');
        },
      ),
    ]);
  }

  @override
  void update(double dt) {}

  onCollision() {
    AppStorage.bestMiles.val =
        math.max(AppStorage.bestMiles.val, player.timer.round());
    AppStorage.lastScore.val = player.timer.round();
    game.router.pushNamed('game_over');
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump(); // Прыжок игрока
  }
}
