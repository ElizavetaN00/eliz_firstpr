import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:game/generated/assets_flame_images.dart';
import '../components/rotating_image_component.dart';
import '../thrill_run_game.dart';
import '../components/logical_size_component.dart';

class MenuLoadingPage extends LogicalSizeComponent<ThrillRunGame>
    with TapCallbacks {
  @override
  Future<void> onLoad() async {
    final imageBg =
        Flame.images.fromCache(AssetsFlameImages.preloader_BG_Loader);
    final imageLogo = Flame.images.fromCache(AssetsFlameImages.preloader_logo);
    final spinnerImage =
        Flame.images.fromCache(AssetsFlameImages.preloader_spiner);
    final spinnerSprite = Sprite(spinnerImage);
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
            size: logicalSize(830, 600),
            position: Vector2(logicalWidth(-130), logicalHeight(24)),
            sprite: Sprite(
              imageLogo,
            ),
          ),
          RotatingImageComponent(
            anchor: Anchor.topRight,
            position: Vector2(logicalWidth(-334), logicalHeight(783)),
            size: logicalSizeCircle(240),
            sprite: spinnerSprite,
          ),
        ],
      ),
    ]);
  }

  pushToMenu() async {
    await Future.delayed(Duration(seconds: 1));
    game.router.pushNamed('menu');
  }

  @override
  void onMount() {
    super.onMount();
    pushToMenu();
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) => game.router.pushNamed('menu');
}
