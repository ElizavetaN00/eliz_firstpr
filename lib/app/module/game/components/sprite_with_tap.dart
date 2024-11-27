import 'package:flame/components.dart';
import 'package:flame/events.dart';

class SpriteWithTap extends SpriteComponent with TapCallbacks {
  void Function() onTap;
  SpriteWithTap({
    required this.onTap,
    super.children,
    super.anchor,
    super.sprite,
    super.size,
    super.position,
  });

  @override
  void onTapDown(TapDownEvent event) {
    onTap.call();
    super.onTapDown(event);
  }
}
