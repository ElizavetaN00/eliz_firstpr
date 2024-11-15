import 'dart:math';

import 'package:flutter/material.dart';

import '../components/hextile/color_crystal.dart';

class HoleListGenerator {
  static List<Color> generateHoleList() {
    final random = Random();

    final blueColors = List<Color>.generate(5, (index) {
      return ColorCrystal.baseColors[0];
    });

    final redColors = List<Color>.generate(5, (index) {
      return ColorCrystal.baseColors[1];
    });

    final yellowColors = List<Color>.generate(5, (index) {
      return ColorCrystal.baseColors[2];
    });

    final list = blueColors + redColors + yellowColors;

    // Функция для проверки условия
    bool isValidShuffle(List<Color> arr) {
      int count = 1;
      for (int i = 1; i < arr.length; i++) {
        if (arr[i] == arr[i - 1]) {
          count++;
          if (count > 3) {
            return false; // Проверка на 4 одинаковых подряд
          }
        } else {
          count = 1;
        }
      }
      return true;
    }

    // Перемешиваем, пока не будет удовлетворено условие
    do {
      list.shuffle(random);
    } while (!isValidShuffle(list));

    return list;
  }
}
