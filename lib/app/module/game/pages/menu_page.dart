import 'package:color_puzzle/data/storage/storage.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import '../components/sprite_with_tap.dart';
import '../game.dart';
import '../components/logical_size_component.dart';

class MenuPage extends LogicalSizeComponent<AppGame> {
  @override
  Future<void> onLoad() async {
    final imageBg = Flame.images.fromCache('Background 2.png');
    final playButton = Flame.images.fromCache('Button 1.png');

    FlameAudio.bgm.initialize();

    await FlameAudio.bgm.stop();
    await FlameAudio.bgm.play('Backgrond.wav');
    if (!AppStorage.musicEnabled.val) {
      await FlameAudio.bgm.pause();
    }

    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      SpriteWithTap(
        anchor: Anchor.center,
        size: logicalSize(1278, 760),
        position: LogicalSize.logicalPositionCenter(),
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
