import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../game.dart';
import '../logical_size_component.dart';

class PlayerComponent extends SpriteAnimationComponent with HasGameRef<AppGame>, CollisionCallbacks, KeyboardHandler {
  double timer = 0;
  double speed = 100; // Speed of the player movement in pixels per second

  @override
  Future<void> onLoad() async {
    final spritesNum = [
      1,
      2,
    ];
    var sprites = spritesNum.map((i) => Sprite.load('img-$i.png'));

    animation = SpriteAnimation.spriteList(
      await Future.wait(sprites),
      stepTime: 2,
    );
    playing = true;
    size = LogicalSize.logicalSize(267, 500);
    anchor = Anchor.bottomLeft;
    position = Vector2(
      LogicalSize.logicalWidth(380),
      gameRef.canvasSize.y - 24,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateMoving(dt);
  }

  MovingDirection movingDirection = MovingDirection.none;
  PlayerDirectionSprite playerDirectionSprite = PlayerDirectionSprite.right;
  updateSpriteDirection() {
    if (movingDirection == MovingDirection.left) {
      playerDirectionSprite = PlayerDirectionSprite.left;
      position.x += size.x;
      scale.x = -1; // Отражаем по горизонтали
    } else if (movingDirection == MovingDirection.right) {
      if (playerDirectionSprite == PlayerDirectionSprite.right) {
        return;
      }
      playerDirectionSprite = PlayerDirectionSprite.right;
      position.x -= size.x;
      scale.x = 1; // Устанавливаем нормальное отображение
    }
  }

  updateMoving(dt) {
    //prevent border collision
    if (position.x < 0) {
      position.x = 0;
    }
    if (position.x > gameRef.canvasSize.x - size.x) {
      position.x = gameRef.canvasSize.x - size.x;
    }

    switch (movingDirection) {
      case MovingDirection.left:
        position.x -= speed * dt;
        break;
      case MovingDirection.right:
        position.x += speed * dt;
        break;
      case MovingDirection.none:
        break;
    }
  }

  startMoveRight() {
    if (movingDirection == MovingDirection.right) {
      return;
    }
    movingDirection = MovingDirection.right;
    updateSpriteDirection();
  }

  stopMoving() {
    movingDirection = MovingDirection.none;
  }

  startMoveLeft() {
    if (movingDirection == MovingDirection.left) {
      return;
    }
    movingDirection = MovingDirection.left;
    updateSpriteDirection();
  }
}

enum MovingDirection { left, right, none }

enum PlayerDirectionSprite { left, right }
