import 'package:color_puzzle/app/module/game/components/horizontal_component.dart';
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
  late VerticalComponents crystalsQueue;

  AppGame get game => findGame()! as AppGame;

  int score = 1000;

  @override
  Future<void> onLoad() async {
    final imageBg = Flame.images.fromCache('Background-Secondary.png');
    final settingImage = Flame.images.fromCache('Btn-Setting.png');
    final restartImage = Flame.images.fromCache('Btn-Restart.png');
    final frame = Flame.images.fromCache('Sidebar (2).png');
    game.score = score;
    final frameSprite = SpriteComponent(
      size: LogicalSize.logicalSize(430, 1040),
      position: LogicalSize.logicalSize(1710, 20),
      paint: Paint()..color = Colors.white.withOpacity(0.5),
      sprite: Sprite(
        frame,
      ),
    );

    final currentCrystals = game.holeColorList.getRange(10, 15).toList();
    final List<CrystallInQue> crystalsQueueComponent = [];

    for (var i = currentCrystals.length - 2; i >= 0; i--) {
      final crystal = currentCrystals[i];
      final crystalComponent = CrystallInQue(
        position: Vector2(0, 200 + i * 100),
        colorCrystal: ColorCrystal(currentColor: crystal),
      );
      crystalsQueueComponent.add(crystalComponent);
    }

    crystalsQueue = VerticalComponents(
      position: LogicalSize.logicalSize(1930, 540),
      anchor: Anchor.topLeft,
      0,
      list: crystalsQueueComponent,
    );

    size = game.canvasSize;

    hexGridComponent = HexGridComponent(game.canvasSize);

    final nextSprite = SpriteComponent(
      size: LogicalSize.logicalSize(90, 35),
      anchor: Anchor.topLeft,
      position: LogicalSize.logicalSize(1880, 419),
      sprite: Sprite(
        Flame.images.fromCache(
          'Next.png',
        ),
      ),
    );

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
      currentCrystalComponent,
      crystalsQueue,
      nextSprite
    ]);
  }

  setQueueCrystals() {
    final currentCrystals = game.holeColorList.getRange(10, 15).toList();
    final List<CrystallInQue> crystalsQueueComponent = [];

    for (var i = currentCrystals.length - 2; i >= 0; i--) {
      final crystal = currentCrystals[i];
      final crystalComponent = CrystallInQue(
        position: Vector2(0, 200 + i * 100),
        colorCrystal: ColorCrystal(currentColor: crystal),
      );
      crystalsQueueComponent.add(crystalComponent);
    }

    final crystalsVertical = VerticalComponents(
      position: LogicalSize.logicalSize(1930, 540),
      0,
      list: crystalsQueueComponent,
    );
    remove(crystalsQueue);
    crystalsQueue = crystalsVertical;
    add(crystalsQueue);
  }

  CrystallForTile get currentCrystalComponent => CrystallForTile(
        position: Vector2(LogicalSize.logicalWidth(1920), 100),
        colorCrystal: ColorCrystal(currentColor: game.currentColor),
      );

  gameOver() {
    var allHexRemoved = false;
    for (var row in hexGridComponent.hexTiles) {
      for (var hexTile in row) {
        if (!hexTile.isTileRemoved) {
          allHexRemoved = false;
          break;
        }
        allHexRemoved = true;
      }
    }
    if (allHexRemoved) {
      changeScore(2000);
    }
    game.score = score;
    game.router.pushNamed('game_over');
  }

  onSetTile() {
    removeWhere((element) => element is CrystallForTile);
    if (AppStorage.soundEnabled.val) FlameAudio.play('remove4gems.wav');
    game.nextColor();
    currentCrystalComponent.removeFromParent();
    add(currentCrystalComponent);
    changeScore(-5);
    setQueueCrystals();
  }

  @override
  void onMount() {
    Future.delayed(Duration.zero, () {
      hexGridComponent.addRandomCrystals();
    });

    super.onMount();
  }

  void changeScore(int value) {
    final newScore = score + value;
    if (newScore < 30) {
      score = 30;
    } else {
      score = newScore;
    }
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
            240,
            240,
          ),
        ) {
    sprite = Sprite(Flame.images
        .fromCache(colorCrystal.getFirstColor(colorCrystal.currentColor)));
    startPosition = position;
    // debugMode = true;
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
    position = position + event.canvasDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    handleDragEnd();
    super.onDragEnd(event);
  }

  void handleDragEnd() {
    if (isColliding) {
      canBeSetted = true;
    } else {
      position = startPosition;
    }
  }

  @override
  void onCollision(Set<Vector2> position, PositionComponent other) {
    if (canBeSetted) {
      if (other is HexTile) {
        if (other.isTileRemoved ||
            other.colorCrystal.currentColor == Colors.brown) {
          canBeSetted = false;

          this.position = startPosition;

          return;
        }
        other.setColor(colorCrystal.currentColor);
      }
    }

    super.onCollision(position, other);
  }
}

class CrystallInQue extends SpriteComponent {
  CrystallInQue({
    required Vector2 position,
    required this.colorCrystal,
    super.anchor = Anchor.center,
  }) : super(
          position: position,
          size: LogicalSize.logicalSize(
            120,
            120,
          ),
        ) {
    sprite = Sprite(Flame.images
        .fromCache(colorCrystal.getFirstColor(colorCrystal.currentColor)));
  }
  final ColorCrystal colorCrystal;
}
