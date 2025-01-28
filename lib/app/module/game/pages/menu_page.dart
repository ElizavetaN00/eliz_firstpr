import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'dart:io' as io;
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

  late SpriteWithTap musicComponent;
  late SpriteWithTap soundComponent;

  @override
  void update(double dt) {
    final musicOn = Flame.images.fromCache('menu/sond_on-1.png');
    final musicOff = Flame.images.fromCache('menu/music_off.png');
    final soundOn = Flame.images.fromCache('menu/sond_on.png');
    final soundOff = Flame.images.fromCache('menu/sond_off.png');
    if (music) {
      musicComponent.sprite = Sprite(musicOn);
    } else {
      musicComponent.sprite = Sprite(musicOff);
    }
    if (sound) {
      soundComponent.sprite = Sprite(soundOn);
    } else {
      soundComponent.sprite = Sprite(soundOff);
    }
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    int bestScore = AppStorage.bestMiles.val;
    bool sound = AppStorage.soundEnabled.val;

    final imageBg = Flame.images.fromCache('menu/menu_bg.png');
    final imageLogo = Flame.images.fromCache('menu/logo.png');
    final selectLevel = Flame.images.fromCache('menu/select_level.png');
    final soundOn = Flame.images.fromCache('menu/sond_on.png');
    final soundOff = Flame.images.fromCache('menu/sond_off.png');
    final musicOn = Flame.images.fromCache('menu/sond_on-1.png');
    final musicOff = Flame.images.fromCache('menu/music_off.png');
    final exit = Flame.images.fromCache('menu/exit.png');

    FlameAudio.bgm.initialize();

    await FlameAudio.bgm.stop();
    if (music) await FlameAudio.bgm.play('Background.wav');

    if (music) {
      musicSprite = Sprite(
        musicOn,
      );
    } else {
      musicSprite = Sprite(
        musicOff,
      );
    }

    if (sound) {
      soundSprite = Sprite(
        soundOn,
      );
    } else {
      soundSprite = Sprite(
        soundOff,
      );
    }

    musicComponent = SpriteWithTap(
      anchor: Anchor.topRight,
      size: logicalSizeCircle(122),
      sprite: musicSprite,
      onTap: () async {
        final music = !AppStorage.musicEnabled.val;
        AppStorage.musicEnabled.val = music;
        await FlameAudio.bgm.stop();
        if (music) {
          await FlameAudio.bgm.play('Background.wav');
        }
      },
    );

    soundComponent = SpriteWithTap(
      anchor: Anchor.topRight,
      size: logicalSizeCircle(122),
      sprite: soundSprite,
      onTap: () async {
        final sound = !AppStorage.soundEnabled.val;
        AppStorage.soundEnabled.val = sound;
      },
    );
    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      PositionComponent(
        anchor: Anchor.topRight,
        position: Vector2(game.canvasSize.x, 0),
        children: [
          SpriteComponent(
            anchor: Anchor.topRight,
            size: logicalSize(650, 470),
            position: logicalSize(-130, 24),
            sprite: Sprite(
              imageLogo,
            ),
          ),
          SpriteWithTap(
            onTap: () => game.router.pushNamed('select_level'),
            anchor: Anchor.topRight,
            size: logicalSize(538, 110),
            position: Vector2(
              logicalWidth(-184),
              logicalHeight(551),
            ),
            sprite: Sprite(
              selectLevel,
            ),
          ),
          ComponentsHorizontal(logicalWidth(86),
              anchor: Anchor.center,
              position: Vector2(
                logicalWidth(-600),
                logicalHeight(711),
              ),
              list: [
                soundComponent,
                musicComponent,
                SpriteWithTap(
                  anchor: Anchor.topRight,
                  size: logicalSizeCircle(122),
                  sprite: Sprite(
                    exit,
                  ),
                  onTap: () {
                    io.exit(0);
                  },
                ),
              ])
        ],
      )
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}

class PositionedSprite extends SpriteComponent {
  PositionedSprite({
    required Vector2 position,
    required Vector2 size,
    required Sprite sprite,
  }) : super(
          position: position,
          size: size,
          sprite: sprite,
        );
}

class ComponentsVertical extends PositionComponent {
  ComponentsVertical(
    this.offset, {
    required this.list,
  });
  final List<PositionComponent> list;
  final double offset;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    double yOffset = 0;

    for (var item in list) {
      item.position = Vector2(0, yOffset);
      add(item);
      yOffset += offset;
    }
  }
}

class ComponentsHorizontal extends PositionComponent {
  ComponentsHorizontal(this.offset,
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
