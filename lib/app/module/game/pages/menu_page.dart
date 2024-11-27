import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import '../../../../data/storage/storage.dart';
import '../../../../generated/assets_flame_images.dart';
import '../components/my_sprite_component/my_sprite_component.dart';
import '../components/my_sprite_component/tap_original_size.dart';
import '../game.dart';
import '../components/logical_size_component.dart';

class MenuPage extends LogicalSizeComponent<AppGame> {
  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.bgm.stop();
    await FlameAudio.bgm.play('background.wav');
    if (!AppStorage.musicEnabled.val) {
      await FlameAudio.bgm.pause();
    }
    final imageBg = Flame.images.fromCache(AssetsFlameImages.img_10081453_1);
    final imageLogo = Flame.images.fromCache(AssetsFlameImages.img_1_copy_1);
    final playButton = Flame.images.fromCache(AssetsFlameImages.Frame_5);

    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      OriginalSizeLogicSpriteComponent(
        anchor: Anchor.topLeft,
        position: Vector2.zero(),
        sprite: Sprite(
          imageLogo,
        ),
      ),
      OriginalSpriteWithTap(
        anchor: Anchor.center,
        position: Vector2(game.canvasSize.x / 2,
            game.canvasSize.y - logicalHeight(120 + 100)),
        sprite: Sprite(
          playButton,
        ),
        onTap: () {
          game.router.pushNamed('game');
        },
      ),
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
