import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import '../../../../../data/storage/storage.dart';
import '../../game.dart';
import '../logical_size_component.dart';

class PlayerComponent extends SpriteAnimationComponent
    with HasGameRef<AppGame>, CollisionCallbacks {
  PlayerComponent({required this.onCollisionStartFunc});

  final double gravity = 800; // Сила гравитации

  double get jumpVelocity =>
      LogicalSize.logicalHight(-1300); // Начальная скорость прыжка

  double velocityY = 0; // Текущая вертикальная скорость

  bool isOnGround = true; // Флаг, указывающий, находится ли игрок на земле

  final Function() onCollisionStartFunc;
  double timer = 0;

  @override
  Future<void> onLoad() async {
    final spritesNum = [1, 2, 3, 4, 5, 6, 7, 8];
    for (var sprite in spritesNum) {
      await Flame.images.load('game/$sprite.png');
    }
    var sprites = spritesNum.map((i) => Sprite.load('game/$i.png'));

    animation = SpriteAnimation.spriteList(
      await Future.wait(sprites),
      stepTime: 0.1,
    );
    animation = animation;
    playing = true;
    size = LogicalSize.logicalSize(475, 500);
    anchor = Anchor.bottomLeft;
    position = Vector2(
      LogicalSize.logicalWidth(380),
      gameRef.canvasSize.y - 24,
    );
    size = LogicalSize.logicalSize(475, 500);
    add(RectangleHitbox(
        size: size / 1.5, position: size / 1.5, anchor: Anchor.center));
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
      playing = true; // Включаем анимацию
    } else {
      playing = false; // Останавливаем анимацию, если в воздухе
    }
    timer = dt + timer;
  }

  void jump() {
    if (isOnGround) {
      if (AppStorage.soundEnabled.val) {
        FlameAudio.play('Jump.wav');
      }
      velocityY = jumpVelocity; // Устанавливаем начальную скорость прыжка
      isOnGround = false; // Флаг, что игрок в воздухе
      playing = false; // Останавливаем анимацию
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    onCollisionStartFunc.call();
    super.onCollisionStart(intersectionPoints, other);
  }
}
