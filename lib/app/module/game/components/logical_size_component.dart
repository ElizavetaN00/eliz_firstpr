import 'package:flame/components.dart';
import 'package:flame/game.dart';

class LogicalSizeComponent<T extends FlameGame> extends PositionComponent with HasGameReference<T> {
  // get device orientation
  bool get isPortrait => game.canvasSize.x < game.canvasSize.y;

  Vector2 logicalSize(int xPoints, int yPoints) => Vector2(
        game.canvasSize.x / (isPortrait ? 1080 : 2160) * xPoints,
        game.canvasSize.y / (isPortrait ? 2160 : 1080) * yPoints,
      );
  Vector2 logicalSizeCircle(int height) => Vector2(
        game.canvasSize.x / (isPortrait ? 1080 : 2160) * height,
        game.canvasSize.x / (isPortrait ? 1080 : 2160) * height,
      );

  double logicalHeight(int points) => game.canvasSize.y / (isPortrait ? 2160 : 1080) * points;
  double logicalWidth(int points) => game.canvasSize.x / (isPortrait ? 1080 : 2160) * points;

  Vector2 logicalPositionCenter() => Vector2(
        game.canvasSize.x / 2,
        game.canvasSize.y / 2,
      );
}

class LogicalSize {
  static Vector2? _canvasSize;
  static bool get isPortrait => ((_canvasSize?.x ?? 0) < (((_canvasSize?.y) ?? 0).toDouble()));

  static setSize(Vector2 size) {
    _canvasSize = size;
  }

  static double get logicalXCenter => (isPortrait ? 1080 : 2160) / 2;

  static double get logicalYCenter => (isPortrait ? 2160 : 1080) / 2;

  static Vector2 logicalPositionCenter() => Vector2(
        _canvasSize!.x / 2,
        _canvasSize!.y / 2,
      );

  static Vector2 logicalSize(double xPoints, double yPoints) => Vector2(
        _canvasSize!.x / (isPortrait ? 1080 : 2160) * xPoints,
        _canvasSize!.y / (isPortrait ? 2160 : 1080) * yPoints,
      );
  static Vector2 logicalSizeCircle(int height) => Vector2(
        _canvasSize!.x / (isPortrait ? 1080 : 2160) * height,
        _canvasSize!.x / (isPortrait ? 1080 : 2160) * height,
      );

  static double logicalHight(int points) => _canvasSize!.y / (isPortrait ? 2160 : 1080) * points;
  static double logicalWidth(int points) => _canvasSize!.x / (isPortrait ? 1080 : 2160) * points;
}
