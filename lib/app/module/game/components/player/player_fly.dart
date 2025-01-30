import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import '../../../../../data/storage/storage.dart';
import '../../thrill_run_game.dart';
import '../logical_size_component.dart';

class PlayerComponentFly extends SpriteAnimationComponent with HasGameRef<ThrillRunGame>, CollisionCallbacks {
  PlayerComponentFly({required this.onCollisionStartFunc});

  final double gravity = 300; // Сила гравитации

  double get jumpVelocity => LogicalSize.logicalHight(-300); // Начальная скорость прыжка

  double velocityY = 0; // Текущая вертикальная скорость

  bool isOnGround = true; // Флаг, указывающий, находится ли игрок на земле

  final Function() onCollisionStartFunc;
  double timer = 0;

  late SpriteAnimation runAnimation;

  @override
  Future<void> onLoad() async {
    debugMode = true;

    final spritesRun = [1, 2, 3, 4, 5];

    for (var sprite in spritesRun) {
      await Flame.images.load('game/animation_flight/Group-$sprite.png');
    }

    var runSprites = spritesRun.map((i) => Sprite.load('game/animation_flight/Group-$i.png'));

    runAnimation = SpriteAnimation.spriteList(
      await Future.wait(runSprites),
      stepTime: 0.08,
    );

    animation = runAnimation;
    playing = true;
    anchor = Anchor.bottomLeft;
    position = Vector2(
      LogicalSize.logicalWidth(380),
      gameRef.canvasSize.y / 2,
    );

    size = LogicalSize.logicalSize(683, 300);
    size = size / 1.2;
    add(RectangleHitbox(size: size, position: Vector2(size.x, 0), anchor: Anchor.topRight));
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocityY += gravity * dt;
    y += velocityY * dt;

    if (y >= gameRef.canvasSize.y - 24) {
      y = gameRef.canvasSize.y - 24; // Возвращаем на уровень земли
      velocityY = 0; // Сбрасываем скорость
      isOnGround = true; // Устанавливаем флаг, что игрок на земле
      animation = runAnimation; // Включаем анимацию бега
      playing = true;
    } else if (y <= 0) {
      y = 0; // Ограничиваем верхнюю границу
      velocityY = 0; // Сбрасываем скорость
    } else {
      playing = true;
    }
    timer = dt + timer;
  }

  void jump() {
    velocityY = jumpVelocity; // Устанавливаем начальную скорость прыжка
    playing = true;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    onCollisionStartFunc.call();
    super.onCollisionStart(intersectionPoints, other);
  }
}
