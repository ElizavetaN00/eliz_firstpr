import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../../../../data/storage/storage.dart';
import '../components/grid/grid_component.dart';
import '../components/hextile/color_crystal.dart';
import '../components/hextile/hextile_component.dart';
import '../components/player/player.dart';
import '../components/logical_size_component.dart';
import 'dart:math' as math;

import '../components/sprite_with_tap.dart';
import '../game.dart';

class GamePage extends PositionComponent with TapCallbacks {
  late final PlayerComponent player;
  AppGame get game => findGame()! as AppGame;

  @override
  Future<void> onLoad() async {
    final imageBg = Flame.images.fromCache('Background-Secondary.png');
    final settingImage = Flame.images.fromCache('Btn-Setting.png');
    final restartImage = Flame.images.fromCache('Btn-Restart.png');
    final frame = Flame.images.fromCache('Sidebar (2).png');
    final frameSprite = SpriteComponent(
      size: LogicalSize.logicalSize(430, 1040),
      position: LogicalSize.logicalSize(1710, 20),
      paint: Paint()..color = Colors.white.withOpacity(0.5),
      sprite: Sprite(
        frame,
      ),
    );

    size = game.canvasSize;

    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      SpriteWithTap(
        anchor: Anchor.topLeft,
        size: LogicalSize.logicalSize(173, 153),
        position: LogicalSize.logicalSize(40, 40),
        sprite: Sprite(
          settingImage,
        ),
        onTap: () {
          game.router.pushNamed('settings');
        },
      ),
      SpriteWithTap(
        anchor: Anchor.topLeft,
        size: LogicalSize.logicalSize(173, 153),
        position: LogicalSize.logicalSize(40, 253),
        sprite: Sprite(
          restartImage,
        ),
        onTap: () {
          game.router.pushNamed('game');
        },
      ),
      HexGridComponent(game.canvasSize),
      currentCrystalComponent
    ]);
  }

  CrystallForTile get currentCrystalComponent => CrystallForTile(
        position: Vector2(game.canvasSize.x - 100, 100),
        colorCrystal: ColorCrystal(currentColor: game.currentColor),
        collisionCallback: onSetTile,
      );

  onSetTile() {
    removeWhere((element) => element is CrystallForTile);
    game.nextColor();
    add(currentCrystalComponent);
  }

  @override
  void update(double dt) {}

  onCollision() {
    AppStorage.bestMiles.val =
        math.max(AppStorage.bestMiles.val, player.timer.round());
    AppStorage.lastScore.val = player.timer.round();
    game.router.pushNamed('game_over');
  }
}

class CrystallForTile extends SpriteComponent
    with DragCallbacks, CollisionCallbacks {
  CrystallForTile({
    required Vector2 position,
    required this.colorCrystal,
    this.collisionCallback,
    super.anchor = Anchor.center,
  }) : super(
          position: position,
          size: LogicalSize.logicalSize(
            100,
            100,
          ),
        ) {
    sprite = Sprite(Flame.images
        .fromCache(colorCrystal.getFirstColor(colorCrystal.currentColor)));
    startPosition = position;
    debugMode = true;
    add(
      RectangleHitbox(
          size: Vector2.all(1), anchor: Anchor.center, position: size / 2),
    );
  }

  var startPosition;
  bool canBeSetted = false;
  final Function()? collisionCallback;
  final ColorCrystal colorCrystal;
  @override
  void onDragUpdate(DragUpdateEvent event) {
    position = position + event.delta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (isColliding) {
      canBeSetted = true;
      collisionCallback?.call();
    } else {
      position = startPosition;
    }
    super.onDragEnd(event);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (canBeSetted) {
      if (other is HexTile) {
        other.setColor(this);
        removeFromParent();
      }
    }

    super.onCollisionEnd(other);
  }
}
