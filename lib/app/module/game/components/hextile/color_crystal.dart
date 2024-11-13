import 'package:flutter/material.dart';

class ColorCrystal {
  ColorCrystal({this.currentColor = Colors.transparent});
  Color currentColor;

  // Карта для связи цвета с соответствующим спрайтом
  static final Map<Color, String> colorToSprite = {
    Colors.blue: 'Crystal - Blue.png',
    Colors.brown: 'Crystal - Brown 1.png',
    Colors.green: 'Crystal - Green.png',
    Colors.red: 'Crystal - Red.png',
    Colors.purple: 'Crystal - Violet.png',
    Colors.yellow: 'Crystal - Yellow.png',
    Colors.orange: 'Crystal -Orange.png',
  };

  static final List<Color> baseColors = [Colors.blue, Colors.red, Colors.yellow];

  Color mixColors(Color color1, Color color2) {
    // Mix Red and Blue to get Purple
    if ((color1 == Colors.red && color2 == Colors.blue) || (color1 == Colors.blue && color2 == Colors.red)) {
      return Colors.purple;
    }
    // Mix Red and Yellow to get Orange
    else if ((color1 == Colors.red && color2 == Colors.yellow) || (color1 == Colors.yellow && color2 == Colors.red)) {
      return Colors.orange;
    }
    // Mix Blue and Yellow to get Green
    else if ((color1 == Colors.blue && color2 == Colors.yellow) || (color1 == Colors.yellow && color2 == Colors.blue)) {
      return Colors.green;
    }
    // Mix Red and Brown to keep Brown
    else if ((color1 == Colors.red && color2 == Colors.brown) || (color1 == Colors.brown && color2 == Colors.red)) {
      return Colors.brown;
    }
    // Mix Blue and Brown to keep Brown
    else if ((color1 == Colors.blue && color2 == Colors.brown) || (color1 == Colors.brown && color2 == Colors.blue)) {
      return Colors.brown;
    }
    // Mix Yellow and Brown to keep Brown
    else if ((color1 == Colors.yellow && color2 == Colors.brown) ||
        (color1 == Colors.brown && color2 == Colors.yellow)) {
      return Colors.brown;
    }
    // Mix Green and Brown to keep Brown
    else if ((color1 == Colors.green && color2 == Colors.brown) || (color1 == Colors.brown && color2 == Colors.green)) {
      return Colors.brown;
    }
    // Mix Orange and Brown to keep Brown
    else if ((color1 == Colors.orange && color2 == Colors.brown) ||
        (color1 == Colors.brown && color2 == Colors.orange)) {
      return Colors.brown;
    }
    // Mix Purple and Brown to keep Brown
    else if ((color1 == Colors.purple && color2 == Colors.brown) ||
        (color1 == Colors.brown && color2 == Colors.purple)) {
      return Colors.brown;
    }
    // Default return if no mixing rules apply
    return color1;
  }

  // Функция для добавления нового цвета и применения смешивания
  String? getSpritePath(Color newColor) {
    currentColor = mixColors(currentColor, newColor);
    return colorToSprite[currentColor];
  }

  String getFirstColor(Color color) {
    return colorToSprite[color]!;
  }
}
