import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../game.dart';

class RotatingImageComponent extends SpriteComponent with HasGameRef<AppGame> {
  RotatingImageComponent(
      {super.sprite, super.position, super.size, super.anchor});

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;

    final effect = RotateEffect.by(
      2 * 3.14,
      EffectController(
        infinite: true,
        duration: 2,
      ),
    );

    add(effect);
  }
}
