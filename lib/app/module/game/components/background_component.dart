import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Background extends Component {
  Background(this.color);
  final Color color;

  @override
  void render(Canvas canvas) {
    canvas.drawColor(color, BlendMode.srcATop);
  }
}

class BackgroundWithTap extends Component with TapCallbacks {
  BackgroundWithTap(this.color, this.onTap);
  final Color color;
  final void Function() onTap;

  @override
  void render(Canvas canvas) {
    canvas.drawColor(color, BlendMode.srcATop);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onTap.call();
  }
}
