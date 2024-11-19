import 'package:color_puzzle/app/module/game/components/logical_size_component.dart';
import 'package:color_puzzle/app/module/game/components/sprite_with_tap.dart';
import 'package:color_puzzle/app/module/game/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';

import '../../../../generated/assets_flame_images.dart';

class ColorPage extends LogicalSizeComponent<AppGame> {
  @override
  Future<void> onLoad() async {
    var closeImage = Flame.images.fromCache(AssetsFlameImages.Frame_2);
    add(SpriteWithTap(
        onTap: () {
          game.router.pop();
        },
        anchor: Anchor.topRight,
        size: logicalSize(100, 100),
        position: logicalSize(950, 600),
        sprite: Sprite(closeImage)));
  }
}

class ColorSettingsCard {
  ColorSettingsCard(this.id, this.uncheckedImage, this.checkedImage, this.isChecked);
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
  ColorSettingsCard(1, AssetsFlameImages.Frame_34, AssetsFlameImages.Frame_28, false),
  ColorSettingsCard(2, AssetsFlameImages.Frame_35, AssetsFlameImages.Frame_29, false),
  ColorSettingsCard(3, AssetsFlameImages.Frame_36, AssetsFlameImages.Frame_30, false),
  ColorSettingsCard(4, AssetsFlameImages.Frame_37, AssetsFlameImages.Frame_31, false),
  ColorSettingsCard(5, AssetsFlameImages.Frame_38, AssetsFlameImages.Frame_32, false),
  ColorSettingsCard(6, AssetsFlameImages.Frame_39, AssetsFlameImages.Frame_33, false),
];
