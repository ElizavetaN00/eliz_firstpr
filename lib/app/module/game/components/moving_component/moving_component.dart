import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../game.dart';

class MovingComponent extends SpriteComponent with HasGameReference<AppGame> {
  MovingComponent({
    this.speed = 100,
    required Vector2 position,
    required Vector2 size,
    required this.image,
    this.axis = Axis.vertical,
  }) : super(position: position, size: size);
  final String image;
  final double speed;
  final Axis axis;
  @override
  Future<void> onLoad() async {
    debugMode = kDebugMode;
    sprite = await Sprite.load(image);
    add(RectangleHitbox(size: size / 2, anchor: Anchor.center, position: size / 2));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (axis == Axis.vertical)
      position.y += speed * dt;
    else
      position.x -= speed * dt;

    if (axis == Axis.vertical) {
      if (position.y > game.size.y) {
        removeFromParent();
      }
    } else if (position.x < -size.x) {
      removeFromParent();
    }
  }
}
