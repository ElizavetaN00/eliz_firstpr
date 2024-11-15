import 'package:flutter/material.dart';

class ColorCrystal {
  ColorCrystal({this.currentColor = Colors.transparent});
  Color currentColor;

  // Карта для связи цвета с соответствующим спрайтом
  static final Map<Color, String> colorToSprite = {
    Colors.red: 'Crystal - Red.png',
    Colors.blue: 'Crystal - Blue.png',
    Colors.yellow: 'Crystal - Yellow.png',
    Colors.purple: 'Crystal - Violet.png',
    Colors.orange: 'Crystal -Orange.png',
    Colors.green: 'Crystal - Green.png',
    Colors.brown: 'Crystal - Brown 1.png',
  };

  // Таблица смешивания цветов
  static final Map<Color, Map<Color, Color>> colorMixTable = {
    Colors.red: {
      Colors.red: Colors.red,
      Colors.blue: Colors.purple,
      Colors.yellow: Colors.orange,
      Colors.purple: Colors.red, // Изменено
      Colors.orange: Colors.red, // Изменено
      Colors.green: Colors.brown,
      Colors.brown: Colors.brown,
    },
    Colors.blue: {
      Colors.red: Colors.purple,
      Colors.blue: Colors.blue,
      Colors.yellow: Colors.green,
      Colors.purple: Colors.blue, // Изменено
      Colors.orange: Colors.brown,
      Colors.green: Colors.blue, // Изменено
      Colors.brown: Colors.brown,
    },
    Colors.yellow: {
      Colors.red: Colors.orange,
      Colors.blue: Colors.green,
      Colors.yellow: Colors.yellow,
      Colors.purple: Colors.brown,
      Colors.orange: Colors.yellow, // Изменено
      Colors.green: Colors.yellow, // Изменено
      Colors.brown: Colors.brown,
    },
    Colors.purple: {
      Colors.red: Colors.red, // Изменено
      Colors.blue: Colors.blue, // Изменено
      Colors.yellow: Colors.brown,
      Colors.purple: Colors.purple,
      Colors.orange: Colors.brown,
      Colors.green: Colors.brown,
      Colors.brown: Colors.brown,
    },
    Colors.orange: {
      Colors.red: Colors.red, // Изменено
      Colors.blue: Colors.brown,
      Colors.yellow: Colors.yellow, // Изменено
      Colors.purple: Colors.brown,
      Colors.orange: Colors.orange,
      Colors.green: Colors.brown,
      Colors.brown: Colors.brown,
    },
    Colors.green: {
      Colors.red: Colors.brown,
      Colors.blue: Colors.blue, // Изменено
      Colors.yellow: Colors.yellow, // Изменено
      Colors.purple: Colors.brown,
      Colors.orange: Colors.brown,
      Colors.green: Colors.green,
      Colors.brown: Colors.brown,
    },
    Colors.brown: {
      Colors.red: Colors.brown,
      Colors.blue: Colors.brown,
      Colors.yellow: Colors.brown,
      Colors.purple: Colors.brown,
      Colors.orange: Colors.brown,
      Colors.green: Colors.brown,
      Colors.brown: Colors.brown,
    },
  };

  // Функция для смешивания цветов с использованием таблицы
  Color mixColors(Color color1, Color color2) {
    return colorMixTable[color1]?[color2] ?? Colors.brown;
  }

  // Функция для получения пути к спрайту
  String? getSpritePath(Color newColor) {
    currentColor = mixColors(currentColor, newColor);
    return colorToSprite[currentColor];
  }

  // Дополнительная функция для получения спрайта по цвету
  String getFirstColor(Color color) {
    return colorToSprite[color]!;
  }

  static final secondaryColors = [Colors.purple, Colors.orange, Colors.green];

  static final List<Color> baseColors = [
    Colors.blue,
    Colors.red,
    Colors.yellow
  ];
}
