import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game/app/module/game/pages/menu_page.dart';

import '../../../../data/storage/storage.dart';
import '../components/logical_size_component.dart';
import '../components/sprite_with_tap.dart';
import '../thrill_run_game.dart';

class SelectLevelPage extends LogicalSizeComponent<ThrillRunGame> {
  @override
  Future<void> onLoad() async {
    final imageBg = Flame.images.fromCache('menu/slect_level/bg.png');
    final frame = Flame.images.fromCache('menu/slect_level/frame.png');
    final select1 = Flame.images.fromCache('menu/slect_level/1.png');
    final select2 = Flame.images.fromCache('menu/slect_level/2.png');
    final select3 = Flame.images.fromCache('menu/slect_level/3.png');
    final toOpen50 = Flame.images.fromCache('menu/slect_level/50_to_open.png');
    final toOpen100 =
        Flame.images.fromCache('menu/slect_level/100_to_open.png');
    final selectLevel = Flame.images.fromCache('menu/slect_level/select.png');
    final closeButton = Flame.images.fromCache('menu/exit.png');

    final miles = AppStorage.bestMiles.val;

    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      SpriteComponent(
          anchor: Anchor.center,
          position: logicalPositionCenter(),
          size: logicalSize(1410, 720),
          sprite: Sprite(
            frame,
          ),
          children: [
            SpriteWithTap(
              position: Vector2(logicalWidth(1211), logicalHeight(57)),
              size: logicalSize(110, 110),
              sprite: Sprite(
                closeButton,
              ),
              onTap: () {
                game.router.pop();
              },
            ),
          ])
    ]);
  }
}

// getLevelComponent(
//     {required bool enabled,
//     required Sprite bgSprite,
//     required Sprite buttonSprite,
//     required Function onTap}) {
//   return SpriteWithTap(
//     position: Vector2(0, 0),
//     size: logicalSizeCircle(384),
//     sprite: bgSprite,
//     children: [
//       SpriteComponent(
//         size: logicalSizeCircle(384),
//         sprite: buttonSprite,
//       )
//     ],
//     onTap: () {},
//   );
// }

class LevelComponent extends SpriteWithTap {
  final bool enabled;
  LevelComponent(
      {required this.enabled,
      required super.position,
      required super.size,
      required super.sprite,
      required super.onTap});
}
