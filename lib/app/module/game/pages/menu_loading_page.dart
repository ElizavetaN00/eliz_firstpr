import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import '../components/rotating_image_component.dart';
import '../game.dart';
import '../components/logical_size_component.dart';

class MenuLoadingPage extends LogicalSizeComponent<AppGame> with TapCallbacks {
  @override
  Future<void> onLoad() async {
    final imageBg = Flame.images.fromCache(AssetsFlameImages.Background);
    final textLogo = Flame.images.fromCache(AssetsFlameImages.Logo);
    final imageLogo = Flame.images.fromCache(AssetsFlameImages.img);
    final spinnerImage = Flame.images.fromCache(AssetsFlameImages.Loader);
    // final spinnerSprite = Sprite(spinnerImage);
    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      SpriteComponent(
        anchor: Anchor.topLeft,
        size: logicalSize(1080, 382),
        position: Vector2.zero(),
        sprite: Sprite(
          textLogo,
        ),
      ),
      SpriteComponent(
        anchor: Anchor.topLeft,
        position: Vector2.zero(),
        size: game.canvasSize,
        sprite: Sprite(
          imageLogo,
        ),
      ),
      RotatingImageComponent(
        anchor: Anchor.center,
        //position bottom center
        position: Vector2(game.canvasSize.x / 2, game.canvasSize.y - 100),
        size: logicalSizeCircle(140),
        sprite: Sprite(
          spinnerImage,
        ),
      ),
    ]);
  }

  pushToMenu() async {
    await Future.delayed(const Duration(seconds: 1));
    game.router.pushNamed('menu');
  }

  @override
  void onMount() {
    super.onMount();
    pushToMenu();
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
