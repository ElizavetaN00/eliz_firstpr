import 'package:flame/components.dart';
import '../../thrill_run_game.dart';

class MovingBackground extends PositionComponent with HasGameRef<ThrillRunGame> {
  final double speed;
  late SpriteComponent background1;
  late SpriteComponent background2;

  MovingBackground({
    required Sprite sprite,
    required this.speed,
    required Vector2 size,
  }) {
    // Создаем два экземпляра фона с одинаковыми размерами
    background1 = SpriteComponent(sprite: sprite, size: size);
    background2 = SpriteComponent(sprite: sprite, size: size);

    // Размещаем второй фон сразу за первым
    background1.position = Vector2(0, 0);
    background2.position = Vector2(size.x, 0);

    addAll([background1, background2]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Двигаем оба фона влево
    background1.x -= speed * dt;
    background2.x -= speed * dt;

    // Проверяем, когда фон полностью вышел за экран
    if (background1.x <= -background1.size.x) {
      background1.x = background2.x + background2.size.x;
    }
    if (background2.x <= -background2.size.x) {
      background2.x = background1.x + background1.size.x;
    }
  }
}
