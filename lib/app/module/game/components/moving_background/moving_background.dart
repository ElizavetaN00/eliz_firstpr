import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../game.dart';

class MovingBackground extends PositionComponent with HasGameRef<AppGame> {
  final double speed;
  late SpriteComponent background1;
  late SpriteComponent background2;
  final Axis axis;
  MovingBackground({
    required Sprite sprite,
    this.speed = 100,
    required Vector2 size,
    this.axis = Axis.horizontal,
  }) {
    // Создаем два экземпляра фона с одинаковыми размерами
    background1 = SpriteComponent(sprite: sprite, size: size);
    background2 = SpriteComponent(sprite: sprite, size: size);

    // Размещаем второй фон сразу за первым
    if (axis == Axis.horizontal) {
      background2.x = background1.size.x;
    } else {
      background2.y = background1.size.y;
    }

    addAll([background1, background2]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (axis == Axis.horizontal) {
      moveHorizontal(dt);
    } else {
      moveVertical(dt);
    }
  }

  void moveHorizontal(double dt) {
    background1.x -= speed * dt;
    background2.x -= speed * dt;

    if (background1.x <= -background1.size.x) {
      background1.x = background2.x + background2.size.x;
    }
    if (background2.x <= -background2.size.x) {
      background2.x = background1.x + background1.size.x;
    }
  }

  void moveVertical(double dt) {
    background1.y += speed * dt;
    background2.y += speed * dt;

    if (background1.y >= gameRef.size.y) {
      background1.y = background2.y - background2.size.y;
    }
    if (background2.y >= gameRef.size.y) {
      background2.y = background1.y - background1.size.y;
    }
  }
}
