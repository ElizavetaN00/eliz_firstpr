import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../thrill_run_game.dart';

class RotatingImageComponent extends SpriteComponent
    with HasGameRef<ThrillRunGame> {
  RotatingImageComponent(
      {Sprite? sprite, Vector2? position, Vector2? size, super.anchor})
      : super(size: size, position: position, sprite: sprite);

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
