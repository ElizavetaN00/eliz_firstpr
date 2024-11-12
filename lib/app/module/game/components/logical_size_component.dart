import 'package:flame/components.dart';
import 'package:flame/game.dart';

class LogicalSizeComponent<T extends FlameGame> extends Component
    with HasGameReference<T> {
  Vector2 logicalSize(int xPoints, int yPoints) => Vector2(
        game.canvasSize.x / 2160 * xPoints,
        game.canvasSize.y / 1080 * yPoints,
      );
  Vector2 logicalSizeCircle(int height) => Vector2(
        game.canvasSize.x / 2160 * height,
        game.canvasSize.x / 2160 * height,
      );

  double logicalHeight(int points) => game.canvasSize.y / 1080 * points;
  double logicalWidth(int points) => game.canvasSize.x / 2160 * points;

  Vector2 logicalPositionCenter() => Vector2(
        game.canvasSize.x / 2,
        game.canvasSize.y / 2,
      );
}

class LogicalSize {
  static Vector2? _canvasSize;

  static setSize(Vector2 size) {
    _canvasSize = size;
  }

  static double get logicalXCenter => 2160 / 2;

  static double get logicalYCenter => 1080 / 2;

  static Vector2 logicalPositionCenter() => Vector2(
        _canvasSize!.x / 2,
        _canvasSize!.y / 2,
      );

  static Vector2 logicalSize(double xPoints, double yPoints) => Vector2(
        _canvasSize!.x / 2160 * xPoints,
        _canvasSize!.y / 1080 * yPoints,
      );
  static Vector2 logicalSizeCircle(int height) => Vector2(
        _canvasSize!.x / 2160 * height,
        _canvasSize!.x / 2160 * height,
      );

  static double logicalHight(int points) => _canvasSize!.y / 1080 * points;
  static double logicalWidth(int points) => _canvasSize!.x / 2160 * points;
}
