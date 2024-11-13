import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../../game.dart';
import '../../pages/level_page.dart';
import 'color_crystal.dart';

class HexTile extends PositionComponent
    with HasGameRef<AppGame>, CollisionCallbacks {
  final Function() onUpdateTile;
  bool isTileRemoved = false;

  // Modified getter to also check if crystal sprite exists
  bool get readyForCompare =>
      colorCrystal.currentColor != Colors.transparent && crystalSprite != null;

  ColorCrystal colorCrystal = ColorCrystal();
  SpriteComponent? crystalSprite;
  final double tileRadius;

  HexTile(
    Vector2 position,
    this.onUpdateTile,
    this.tileRadius,
  ) : super(
            position: position,
            size: Vector2.all(tileRadius * 1.8),
            anchor: Anchor.topLeft);
  var hexBackground = HexBackground(
    radius: 1,
    position: Vector2.zero(),
  );
  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    anchor = Anchor.topLeft;
    add(RectangleHitbox(size: size * 0.8, isSolid: true, position: size * 0.1));
    hexBackground = HexBackground(
      radius: tileRadius,
      position: Vector2.zero(),
      size: size,
      anchor: anchor,
    );
    add(hexBackground);
  }

  void setCrystal(Color color) {
    print('Setting crystal with color: $color');
    if (crystalSprite == null) {
      var firstColor = colorCrystal.getFirstColor(color);
      print('First color sprite path: $firstColor');
      var spriteCrystal = Sprite(Flame.images.fromCache(firstColor));
      crystalSprite = SpriteComponent(
          sprite: spriteCrystal,
          size: Vector2.all(tileRadius * 1.7),
          anchor: Anchor.topLeft);
      colorCrystal.currentColor = color;
      add(crystalSprite!);
    } else {
      var spritePath = colorCrystal.getSpritePath(color);
      if (spritePath == null) {
        print('No sprite path found for color: $color');
        return;
      }
      print('Updating sprite path to: $spritePath');
      var spriteCrystal = Sprite(Flame.images.fromCache(spritePath));
      crystalSprite!.sprite = spriteCrystal;
    }
  }

  void setColor(CrystallForTile other) {
    if (isTileRemoved) {
      print('Tile is removed, cannot set color');
      return;
    }

    var color = other.colorCrystal.currentColor;
    print('Setting color from other crystal: $color');
    setCrystal(color);
    onUpdateTile.call();
    game.nextColor();
  }

  void deleteTile() {
    print('Deleting tile at position: $position');
    if (isTileRemoved) {
      print('Tile already removed');
      return;
    }

    if (crystalSprite != null) {
      print('Removing crystal sprite');
      remove(crystalSprite!);
      crystalSprite = null;
    }

    isTileRemoved = true;
    hexBackground.removeBg(true); // Update hex background visibility

    colorCrystal.currentColor = Colors.transparent;
    print('Tile deleted successfully');
  }
}

class HexBackground extends PositionComponent {
  final double radius;
  bool isRemoved;

  HexBackground({
    required this.radius,
    this.isRemoved = false,
    super.position,
    super.size,
    super.anchor,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = isRemoved ? Colors.transparent : Colors.grey.withAlpha(100);
    final path = Path();

    final double centerX = size.x / 2;
    final double centerY = size.y / 2;

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

  void removeBg(bool removed) {
    isRemoved = removed;
  }
}
