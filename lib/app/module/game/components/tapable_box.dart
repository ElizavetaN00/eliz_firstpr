import 'package:flame/components.dart';
import 'package:flame/events.dart';

class TappableBox extends PositionComponent with TapCallbacks {
  final void Function()? onTap;
  TappableBox(
      {required this.onTap,
      required super.position,
      required super.size,
      super.anchor});

  @override
  void onTapDown(TapDownEvent event) {
    onTap?.call();
  }
}
