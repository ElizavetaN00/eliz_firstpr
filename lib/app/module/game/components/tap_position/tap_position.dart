import 'package:flame/components.dart';
import 'package:flame/events.dart';

class TapPositionComponent extends PositionComponent with TapCallbacks {
  Function()? onTap;
  TapPositionComponent(
      {this.onTap,
      super.anchor,
      super.position,
      super.size,
      super.priority,
      super.children,
      super.key});

  @override
  void onTapDown(TapDownEvent event) {
    onTap?.call();
    super.onTapDown(event);
  }
}
