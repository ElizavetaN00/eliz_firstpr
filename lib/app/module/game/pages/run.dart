import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/painting.dart';
import 'package:game/generated/assets_flame_images.dart';

import '../../../../data/storage/storage.dart';
import '../components/moving_background/moving_background.dart';
import '../components/obstacle_component/obstacle.dart';
import '../components/player/player.dart';
import '../components/logical_size_component.dart';
import 'dart:math' as math;

import '../thrill_run_game.dart';

class Run extends PositionComponent with TapCallbacks {
  List<String> obstacleImage = [
    AssetsFlameImages.game_itam_1_min,
    AssetsFlameImages.game_itam_2_min,
    AssetsFlameImages.game_itam_3_min,
    AssetsFlameImages.game_itam_4_min,
    AssetsFlameImages.game_itam_5_min,
    AssetsFlameImages.game_itam_6_min
  ];
  double speed = 200.0;
  var bg = AssetsFlameImages.game_BG_game_runner;
  final Random random = Random();
  double obstacleTimer = 0;
  double nextObstacleInterval = 4;

  late final PlayerComponent player;
  ThrillRunGame get game => findGame()! as ThrillRunGame;

  late final TextComponent scoreComponent;

  @override
  Future<void> onLoad() async {
    player = PlayerComponent(onCollisionStartFunc: () => onCollision());
    size = game.canvasSize;

    final bgImage = game.images.fromCache(bg);

    final background = MovingBackground(
        sprite: Sprite(bgImage), speed: speed, size: Vector2(LogicalSize.logicalWidth(2165), game.canvasSize.y));

    scoreComponent = TextComponent(
      text: '0',
      position: Vector2(LogicalSize.logicalWidth(69), 0),
      textRenderer: TextPaint(
          style: const TextStyle(
        fontSize: 56,
        fontFamily: 'Retro Gaming',
        color: Color(0xFFA60022),
      )),
    );

    addAll([
      background,
      player,
      scoreComponent,
    ]);
  }

  @override
  void update(double dt) {
    obstacleTimer += dt;

    if (obstacleTimer > nextObstacleInterval) {
      obstacleTimer = 0;
      spawnObstacle();
      nextObstacleInterval = 2.8 + random.nextDouble() * 2;
    }

    var score = player.timer.round().toString();
    scoreComponent.text = score;
  }

  void spawnObstacle() {
    //random obstacle
    var index = random.nextInt(obstacleImage.length);
    final obstacle = ObstacleComponent(
      speed: speed,
      position: Vector2(
        size.x,
        size.y - LogicalSize.logicalHight(300),
      ),

      image: obstacleImage[index], // Размер препятствия
    );
    add(obstacle);
  }

  onCollision() {
    AppStorage.bestMiles.val = math.max(AppStorage.bestMiles.val, player.timer.round());
    AppStorage.lastScore.val = player.timer.round();
    // game.router.pushNamed('game_over');
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump(); // Прыжок игрока
  }
}
