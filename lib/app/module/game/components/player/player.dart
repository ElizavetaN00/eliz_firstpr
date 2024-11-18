import 'package:color_puzzle/app/module/game/components/moving_component/coin.dart';
import 'package:color_puzzle/app/module/game/components/moving_component/obstacle.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import '../../game.dart';
import '../../pages/level_page.dart';
import '../logical_size_component.dart';

class PlayerComponent extends SpriteAnimationComponent
    with HasGameRef<AppGame>, CollisionCallbacks, KeyboardHandler {
  double timer = 0;
  double speed = 300; // Speed of the player movement in pixels per second

  @override
  Future<void> onLoad() async {
    debugMode = kDebugMode;
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
    add(RectangleHitbox(size: size));
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
      if (playerDirectionSprite == PlayerDirectionSprite.left) {
        return;
      }
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

    if (movingDirection == MovingDirection.right) {
      if (position.x > gameRef.canvasSize.x - size.x) {
        position.x = gameRef.canvasSize.x - size.x;
      }
    } else {
      if (position.x < 0 + size.x) {
        position.x = 0 + size.x;
      }
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

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CoinComponent) {
      other.removeFromParent();
      (parent as GamePage).score += 20;
    }

    if (other is ObstacleComponent) {
      other.removeFromParent();
      (parent as GamePage).gameOver();
    }
    print('onCollisionStart');
    super.onCollisionStart(intersectionPoints, other);
  }
}

enum MovingDirection { left, right, none }

enum PlayerDirectionSprite { left, right }
