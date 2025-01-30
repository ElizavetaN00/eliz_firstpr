import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../thrill_run_game.dart';

class ObstacleComponent extends SpriteComponent with HasGameReference<ThrillRunGame> {
  ObstacleComponent({
    required this.speed,
    required Vector2 position,
    required this.image,
    this.verticalMirror = false,
  }) : super(position: position);
  final String image;
  final bool verticalMirror;
  final double speed;

  @override
  Future<void> onLoad() async {
    debugMode = true;
    sprite = await Sprite.load(image);

    size = size / 3;
    if (verticalMirror) {
      flipVertically();
    }
    add(CircleHitbox(radius: size.y / 2, anchor: Anchor.center, position: size / 2));
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
