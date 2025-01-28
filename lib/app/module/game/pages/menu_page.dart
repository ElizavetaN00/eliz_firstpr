import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game/generated/assets_flame_images.dart';
import '../../../../data/storage/storage.dart';
import '../components/sprite_with_tap.dart';
import '../thrill_run_game.dart';
import '../components/logical_size_component.dart';

class MenuPage extends LogicalSizeComponent<ThrillRunGame> {
  AudioPlayer? musicPlayer;

  late Sprite musicSprite;

  late Sprite soundSprite;

  bool get music => AppStorage.musicEnabled.val;

  bool get sound => AppStorage.soundEnabled.val;

  @override
  Future<void> onLoad() async {
    int lvl = AppStorage.lvl.val;

    final imageBg = Flame.images.fromCache(AssetsFlameImages.menu_BG_menu);

    FlameAudio.bgm.initialize();

    await FlameAudio.bgm.stop();
    if (music) await FlameAudio.bgm.play('background.wav');

    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
