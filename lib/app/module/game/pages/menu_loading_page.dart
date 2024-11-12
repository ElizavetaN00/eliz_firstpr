import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import '../components/rotating_image_component.dart';
import '../game.dart';
import '../components/logical_size_component.dart';

class MenuLoadingPage extends LogicalSizeComponent<AppGame> with TapCallbacks {
  @override
  Future<void> onLoad() async {
    final imageBg = Flame.images.fromCache('Background 2.png');
    final imageLogo = Flame.images.fromCache('Name.png');
    final spinnerImage = Flame.images.fromCache('Loader.png');
    // final spinnerSprite = Sprite(spinnerImage);
    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      SpriteComponent(
        anchor: Anchor.center,
        size: logicalSize(522, 865),
        position: LogicalSize.logicalPositionCenter(),
        sprite: Sprite(
          imageLogo,
        ),
      ),
      RotatingImageComponent(
        anchor: Anchor.topRight,
        position: Vector2(game.canvasSize.x - 60, game.canvasSize.y - 60),
        size: logicalSizeCircle(100),
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
