import 'dart:async';

import 'package:flame/components.dart';

import '../logical_size_component.dart';

class OriginalSizeLogicSpriteComponent extends SpriteComponent {
  OriginalSizeLogicSpriteComponent(
      {super.position,
      super.sprite,
      super.anchor,
      super.priority,
      super.size,
      super.children,
      super.key});

  @override
  FutureOr<void> onLoad() {
    size =
        LogicalSize.logicalSize(sprite!.originalSize.x, sprite!.originalSize.y);
    return super.onLoad();
  }
}
