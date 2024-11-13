import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../../game.dart';
import '../../pages/level_page.dart';
import 'color_crystal.dart';

class HexTile extends PositionComponent with HasGameRef<AppGame>, CollisionCallbacks {
  final Function() onTileTap;

  static const double tileRadius = 60.0;
  var isTileRemoved = false;
  ColorCrystal colorCrystal = ColorCrystal();
  SpriteComponent? crystalSprite;
  HexTile(
    Vector2 position,
    this.onTileTap,
  ) : super(position: position, size: Vector2.all(tileRadius * 1.8), anchor: Anchor.topLeft);

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    anchor = Anchor.topLeft;
    add(RectangleHitbox(size: size * 0.9, isSolid: true, position: size * 0.05));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = isTileRemoved ? Colors.transparent : Colors.grey.withAlpha(100);
    final path = Path();

    final double centerX = size.x / 2;
    final double centerY = size.y / 2;
    const double radius = tileRadius;

    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i + pi / 6;
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  void setCrystal(Color color) {
    if (crystalSprite == null) {
      var firstColor = colorCrystal.getFirstColor(color);
      var spriteCrystal = Sprite(Flame.images.fromCache(firstColor));
      crystalSprite =
          SpriteComponent(sprite: spriteCrystal, size: Vector2.all(tileRadius * 1.8), anchor: Anchor.topLeft);
      colorCrystal.currentColor = color;
      add(crystalSprite!);
    } else {
      var spritePath = colorCrystal.getSpritePath(color);
      if (spritePath == null) {
        return;
      }
      var spriteCrystal = Sprite(Flame.images.fromCache(spritePath));

      crystalSprite!.sprite = spriteCrystal;
    }
  }

  setColor(CrystallForTile other) {
    if (isTileRemoved) {
      return;
    }
    var color = other.colorCrystal.currentColor;
    setCrystal(color);
    game.nextColor();
  }

  void deleteTile() {
    if (isTileRemoved) {
      return;
    }
    remove(crystalSprite!);
    isTileRemoved = true;
  }
}
