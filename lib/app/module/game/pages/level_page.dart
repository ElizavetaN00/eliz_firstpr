import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../../../../data/storage/storage.dart';
import '../components/grid/grid_component.dart';
import '../components/hextile/color_crystal.dart';
import '../components/hextile/hextile_component.dart';
import '../components/player/player.dart';
import '../components/logical_size_component.dart';

import '../components/sprite_with_tap.dart';
import '../game.dart';

class GamePage extends PositionComponent with TapCallbacks {
  late final PlayerComponent player;
  late final HexGridComponent hexGridComponent;
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

    final levelText = TextComponent(
      text: 'Level 1',
      position: LogicalSize.logicalSize(1800, 40),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    );

    size = game.canvasSize;

    hexGridComponent = HexGridComponent(game.canvasSize);

    addAll([
      SpriteComponent(
        size: game.canvasSize,
        sprite: Sprite(
          imageBg,
        ),
      ),
      frameSprite,
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
          game.newGame();
        },
      ),
      hexGridComponent,
      levelText,
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
    if (AppStorage.soundEnabled.val) FlameAudio.play('remove4gems.wav');
    game.nextColor();
    currentCrystalComponent.removeFromParent();
    add(currentCrystalComponent);
  }

  @override
  void onMount() {
    Future.delayed(Duration.zero, () {
      hexGridComponent.addRandomCrystals();
    });

    super.onMount();
  }

  @override
  void update(double dt) {}
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
    print('onDragEnd');
    handleDragEnd();
    super.onDragEnd(event);
  }

  void handleDragEnd() {
    if (isColliding) {
      canBeSetted = true;
      Future.delayed(Duration.zero, () {});

      // collisionCallback?.call();
    } else {
      position = startPosition;
    }
  }

  @override
  void onCollision(Set<Vector2> position, PositionComponent other) {
    print('onCollisionEnd');
    if (canBeSetted) {
      if (other is HexTile) {
        other.setColor(colorCrystal.currentColor);
        // removeFromParent();
      }
    }

    super.onCollision(position, other);
  }
}
