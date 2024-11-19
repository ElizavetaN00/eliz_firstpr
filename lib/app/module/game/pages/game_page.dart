import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';

import '../components/moving_background/moving_background.dart';
import '../components/player/player.dart';
import '../components/logical_size_component.dart';

import '../components/sprite_with_tap.dart';
import '../game.dart';
import '../utils/asteroid_coins_spawn.dart';

class GamePage extends LogicalSizeComponent<AppGame> with TapCallbacks, AsteroidCoinsSpawn {
  @override
  AppGame get game => findGame()! as AppGame;

  int score = 0;
  late MovingBackground bg;
  late final PlayerComponent player;
  var scoreComponent = TextComponent(
    text: 0.toString(),
    anchor: Anchor.center,
    textRenderer: TextPaint(
      style: const TextStyle(fontSize: 70, color: Colors.white, fontWeight: FontWeight.w700),
    ),
  );
  @override
  Future<void> onLoad() async {
    scoreComponent.position = Vector2(game.size.x / 2, 44);
    size = game.canvasSize;
    final imageBg = Flame.images.fromCache(AssetsFlameImages.img_10081453_1);
    final settingImage = Flame.images.fromCache(AssetsFlameImages.Frame);

    bg = MovingBackground(
      axis: m.Axis.vertical,
      size: game.canvasSize,
      sprite: Sprite(
        imageBg,
      ),
    );
    player = PlayerComponent();
    addAll([
      bg,
      SpriteWithTap(
        anchor: Anchor.topLeft,
        size: LogicalSize.logicalSizeCircle(160),
        position: LogicalSize.logicalSize(40, 40),
        sprite: Sprite(
          settingImage,
        ),
        onTap: () {
          game.router.pushNamed('settings');
        },
      ),
      player,
      scoreComponent,
    ]);
    interval = Timer(
      2,
      onTick: () {
        elapsedSecs += 1;
        spawnObject();
      },
      repeat: true,
    );
  }

  int elapsedSecs = 0;

  late Timer interval;

  @override
  void update(double dt) {
    scoreComponent.text = score.toString();
    super.update(dt);
    interval.update(dt);
  }

  gameOver() {
    score = 0;
    game.router.pushNamed('game_over');
  }

  @override
  void onMount() {
    Future.delayed(Duration.zero, () {});

    super.onMount();
  }

  void changeScore(int value) {
    final newScore = score + value;
    if (newScore < 30) {
      score = 30;
    } else {
      score = newScore;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    final screenSize = size;
    final touchPosition = event.canvasPosition;

    // Проверяем, на какую часть экрана нажал пользователь
    if (touchPosition.x < screenSize.x / 2) {
      player.startMoveLeft();
    } else {
      player.startMoveRight();
    }
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    player.stopMoving();
    super.onTapUp(event);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    player.stopMoving();
    super.onTapCancel(event);
  }
}
