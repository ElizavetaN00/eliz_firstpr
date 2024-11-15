import 'package:flame/components.dart';

class HorizontalComponents extends PositionComponent {
  HorizontalComponents(this.offset,
      {required this.list, super.anchor, super.position});
  final List<PositionComponent> list;
  final double offset;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    double xOffset = 0;

    for (var item in list) {
      item.position = Vector2(xOffset, 0); // Позиционируем компоненты по X
      add(item);
      xOffset += offset + item.width; // Смещаем следующий элемент по оси X
    }
  }
}

class VerticalComponents extends PositionComponent {
  VerticalComponents(this.offset,
      {required this.list, super.anchor, super.position});
  final List<PositionComponent> list;
  final double offset;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    double yOffset = 0;

    for (var item in list) {
      item.position = Vector2(0, yOffset); // Позиционируем компоненты по Y
      add(item);
      yOffset += offset + item.height; // Смещаем следующий элемент по оси Y
    }
  }
}
