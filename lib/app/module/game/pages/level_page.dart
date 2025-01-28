import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/painting.dart';

import '../../../../data/storage/storage.dart';
import '../components/moving_background/moving_background.dart';
import '../components/obstacle_component/obstacle.dart';
import '../components/player/player.dart';
import '../components/logical_size_component.dart';
import 'dart:math' as math;

import '../thrill_run_game.dart';

class LevelPage extends PositionComponent with TapCallbacks {
  LevelPage(
      {required this.speed, required this.bg, required this.obstacleImage});

  factory LevelPage.level1() => LevelPage(
        speed: 300,
        bg: 'game/bg1.png',
        obstacleImage: 'game/obstacle_1.png',
      );
  factory LevelPage.level2() => LevelPage(
        speed: 600,
        bg: 'game/bg2.png',
        obstacleImage: 'game/obstacle_2.png',
      );
  factory LevelPage.level3() => LevelPage(
        speed: 1000,
        bg: 'game/bg3.png',
        obstacleImage: 'game/obstacle_3.png',
      );

  final double speed;
  final String bg;
  final String obstacleImage;

  final Random random = Random();
  double obstacleTimer = 0;
  double nextObstacleInterval = 4;

  late final PlayerComponent player;
  ThrillRunGame get game => findGame()! as ThrillRunGame;

  late final TextComponent scoreComponent;

  late final Image frame;

  @override
  Future<void> onLoad() async {
    player = PlayerComponent(onCollisionStartFunc: () => onCollision());
    size = game.canvasSize;

    final bgImage = game.images.fromCache(bg);

    final background = MovingBackground(
        sprite: Sprite(bgImage),
        speed: speed,
        size: Vector2(LogicalSize.logicalWidth(3800), game.canvasSize.y));

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

    frame = game.images.fromCache('game/score_frame.png');

    final frameSprite = SpriteComponent(
      sprite: Sprite(frame),
      size:
          Vector2(LogicalSize.logicalWidth(340), LogicalSize.logicalHight(265)),
      position: Vector2(0, LogicalSize.logicalHight(27)),
    );

    final milesSprite = SpriteComponent(
      sprite: Sprite(game.images.fromCache('game/miles.png')),
      size:
          Vector2(LogicalSize.logicalWidth(258), LogicalSize.logicalHight(93)),
      position:
          Vector2(LogicalSize.logicalWidth(33), LogicalSize.logicalHight(184)),
    );

    addAll([
      background, // Сначала добавляем фон
      frameSprite,
      player, // Затем игрока
      scoreComponent,
      milesSprite,
    ]);
  }

  @override
  void update(double dt) {
    obstacleTimer += dt;

    if (obstacleTimer > nextObstacleInterval) {
      obstacleTimer = 0;
      spawnObstacle();
      nextObstacleInterval = 2 + random.nextDouble() * 2;
    }

    var score = player.timer.round().toString();
    scoreComponent.text = score;
  }

  void spawnObstacle() {
    // Создаем препятствие в правой части экрана
    final obstacle = ObstacleComponent(
      speed: speed,

      position: Vector2(
        size.x,
        size.y - LogicalSize.logicalHight(200),
      ), // Уровень земли
      size: LogicalSize.logicalSize(520, 250),
      image: obstacleImage, // Размер препятствия
    );
    add(obstacle);
  }

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
