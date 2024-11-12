import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../game.dart';

class ObstacleComponent extends SpriteComponent with HasGameReference<AppGame> {
  ObstacleComponent({
    required this.speed,
    required Vector2 position,
    required Vector2 size,
    required this.image,
  }) : super(position: position, size: size);
  final String image;
  final double speed;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(image);
    add(RectangleHitbox(
        size: size / 2, anchor: Anchor.center, position: size / 2));
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Двигаем препятствие влево
    position.x -= speed * dt; // Скорость движения препятствия

    // Удаляем препятствие, если оно вышло за границу экрана
    if (position.x < -size.x) {
      removeFromParent();
    }
  }
}
