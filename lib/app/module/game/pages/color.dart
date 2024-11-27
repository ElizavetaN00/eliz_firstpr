import 'package:color_puzzle/app/module/game/components/logical_size_component.dart';
import 'package:color_puzzle/app/module/game/components/my_sprite_component/my_sprite_component.dart';
import 'package:color_puzzle/app/module/game/components/my_sprite_component/tap_original_size.dart';
import 'package:color_puzzle/app/module/game/components/tap_position/tap_position.dart';
import 'package:color_puzzle/app/module/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../../../../generated/assets_flame_images.dart';

class ColorPage extends LogicalSizeComponent<AppGame> {
  @override
  Future<void> onLoad() async {
    var bg = Flame.images.fromCache(AssetsFlameImages.Frame_21);

    var spriteComponentBg = OriginalSizeLogicSpriteComponent(
      anchor: Anchor.center,
      position: game.size / 2,
      sprite: Sprite(bg),
    );

    add(spriteComponentBg);
    // Добавление карточек
    double startX = logicalSize(200, 0).x;
    double startY = logicalSize(0, 650).y;
    double offsetX = logicalSize(400, 0).x;
    double offsetY = logicalSize(0, 400).y;
    var colorSettingsNew = colorSettings;
    colorSettingsNew[game.colorId].isChecked = true;
    for (var i = 0; i < colorSettingsNew.length; i++) {
      var card = colorSettingsNew[i];
      var position = Vector2(
        startX + (i % 2) * offsetX,
        startY + (i ~/ 2) * offsetY,
      );

      var spriteComponent = OriginalSpriteWithTap(
        // size: logicalSize(150, 200),
        position: position,
        sprite: Sprite(
          Flame.images.fromCache(
              card.isChecked ? card.checkedImage : card.uncheckedImage),
        ),
        onTap: () {
          // Сброс предыдущих выборов
          for (var otherCard in colorSettings) {
            otherCard.isChecked = false;
          }
          card.isChecked = true;
          game.chengeColor(card.id);
          game.router.pop(); // Обновить экран
        },
      );
      add(spriteComponent);
    }
    add(TapPositionComponent(
      onTap: () {
        game.router.pop();
      },
      position: logicalSize(1000, 210),
      anchor: Anchor.topRight,
      size: logicalSize(140, 140),
    ));
  }
}

class ColorSettingsCard {
  ColorSettingsCard(
      this.id, this.uncheckedImage, this.checkedImage, this.isChecked);
  int id;
  String uncheckedImage;
  String checkedImage;
  bool isChecked;
}

var imagesUnchek = [
  AssetsFlameImages.Frame_34,
  AssetsFlameImages.Frame_35,
  AssetsFlameImages.Frame_36,
  AssetsFlameImages.Frame_37,
  AssetsFlameImages.Frame_38,
  AssetsFlameImages.Frame_39
];

var imagesCheck = [
  AssetsFlameImages.Frame_28,
  AssetsFlameImages.Frame_29,
  AssetsFlameImages.Frame_30,
  AssetsFlameImages.Frame_31,
  AssetsFlameImages.Frame_32,
  AssetsFlameImages.Frame_33
];

var colorSettings = [
  ColorSettingsCard(
      0, AssetsFlameImages.Frame_34, AssetsFlameImages.Frame_28, false),
  ColorSettingsCard(
      1, AssetsFlameImages.Frame_35, AssetsFlameImages.Frame_29, false),
  ColorSettingsCard(
      2, AssetsFlameImages.Frame_36, AssetsFlameImages.Frame_30, false),
  ColorSettingsCard(
      3, AssetsFlameImages.Frame_37, AssetsFlameImages.Frame_31, false),
  ColorSettingsCard(
      4, AssetsFlameImages.Frame_38, AssetsFlameImages.Frame_32, false),
  ColorSettingsCard(
      5, AssetsFlameImages.Frame_39, AssetsFlameImages.Frame_33, false),
];
