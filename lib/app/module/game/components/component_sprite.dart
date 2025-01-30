import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/rendering.dart';

import 'logical_size_component.dart';

class ComponentSpriteWithTap extends SpriteComponent with TapCallbacks {
  final void Function()? onTap;
  final bool originalSize;
  final double relativeSize;
  ComponentSpriteWithTap({
    this.onTap,
    super.children,
    super.anchor,
    super.sprite,
    super.size,
    super.position,
    super.paint,
    this.relativeSize = 1,
    this.originalSize = true,
  }) {
    if (originalSize) {
      size = LogicalSize.logicalSize(
          sprite!.originalSize.x, sprite!.originalSize.y);
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (onTap != null) {
      onTap!.call();
      super.onTapDown(event);
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    if (onTap != null) {
      final smallerWidth = size.x * relativeSize;
      final smallerHeight = size.y * relativeSize;

      final rect = Rect.fromCenter(
        center: Offset(size.x / 2, size.y / 2),
        width: smallerWidth,
        height: smallerHeight,
      );

      return rect.contains(point.toOffset());
    } else {
      return super.containsLocalPoint(point);
    }
  }
}

class ComponentSprite extends SpriteComponent {
  final bool originalSize;
  final double relativeSize;
  ComponentSprite({
    super.children,
    super.anchor,
    super.sprite,
    super.size,
    super.position,
    super.paint,
    this.relativeSize = 1,
    this.originalSize = true,
  }) {
    if (originalSize) {
      size = LogicalSize.logicalSize(
          sprite!.originalSize.x, sprite!.originalSize.y);
    }
  }
}
