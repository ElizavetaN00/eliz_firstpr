import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BlurComponent extends PositionComponent {
  final double blurSigma;

  BlurComponent({
    required Vector2 size,
    this.blurSigma = 10.0,
  }) : super(size: size);

  @override
  void render(Canvas canvas) {
    // Наложение размытия
    canvas.saveLayer(
      null,
      Paint()
        ..imageFilter = ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
    );

    // Рисуем фон (можно задать любой цвет)
    final paint = Paint()..color = Colors.black.withOpacity(0.5);
    canvas.drawRect(size.toRect(), paint);

    canvas.restore();
  }
}
