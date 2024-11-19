// import 'dart:ui';

// import 'package:color_puzzle/app/module/game/components/background_component.dart';
// import 'package:color_puzzle/generated/assets_flame_images.dart';
// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/flame.dart';

// import '../components/logical_size_component.dart';
// import '../components/tapable_box.dart';
// import '../game.dart';

// class TutorialPage extends LogicalSizeComponent<AppGame> with TapCallbacks {
//   late final Image tutorialPopUp;
//   late final SpriteComponent popUpComponent;
//   late final Image closeImage;
//   @override
//   Future<void> onLoad() async {
//     tutorialPopUp = Flame.images.fromCache(AssetsFlameImages.Frame_9);
//     closeImage = Flame.images.fromCache(AssetsFlameImages.Group);

//     popUpComponent = SpriteComponent(
//       anchor: Anchor.topCenter,
//       size: logicalSize(1000, 1050),
//       position: logicalSize(539, 500),
//       sprite: Sprite(
//         tutorialPopUp,
//       ),
//     );
//     final closeButton = TappableBox(
//       anchor: Anchor.topRight,
//       size: logicalSize(100, 100),
//       position: logicalSize(950, 600),
//       onTap: () {
//         game.router.pop();
//       },
//     );

//     final background = Background(const Color(0x99000000));

//     addAll([
//       background,
//       popUpComponent,
//       closeButton,
//     ]);
//   }

//   @override
//   bool containsLocalPoint(Vector2 point) => true;
// }
