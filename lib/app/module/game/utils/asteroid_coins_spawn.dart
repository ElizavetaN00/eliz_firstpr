import 'dart:math';

import 'package:color_puzzle/app/module/game/components/moving_component/coin.dart';
import 'package:color_puzzle/app/module/game/components/logical_size_component.dart';
import 'package:color_puzzle/app/module/game/components/moving_component/obstacle.dart';
import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/components.dart';

import '../game.dart';

mixin AsteroidCoinsSpawn on LogicalSizeComponent<AppGame> {
  final Random random = Random();
  void spawnObject() {
    final isCoin = random.nextBool();

    final object = isCoin
        ? CoinComponent(position: getRandomPosition(), size: logicalSizeCircle(120), image: AssetsFlameImages.Frame_2)
        : ObstacleComponent(
            position: getRandomPosition(), image: AssetsFlameImages.Frame_3, size: logicalSizeCircle(120));

    add(object);
  }

  Vector2 getRandomPosition() {
    final x = random.nextDouble() * game.size.x; // случайная позиция по оси X
    final y = random.nextDouble() * game.size.y / 2; // случайная позиция в верхней части экрана
    return Vector2(x, y);
  }
}
