import 'package:flame/events.dart';

import 'my_sprite_component.dart';

class OriginalSpriteWithTap extends OriginalSizeLogicSpriteComponent
    with TapCallbacks {
  void Function() onTap;
  OriginalSpriteWithTap(
      {required this.onTap,
      super.children,
      super.anchor,
      super.sprite,
      super.size,
      super.position,
      super.key});

  @override
  void onTapDown(TapDownEvent event) {
    onTap.call();
    super.onTapDown(event);
  }
}
