import 'package:color_puzzle/app/module/game/components/blackjack/Dealer.dart';
import 'package:color_puzzle/app/module/game/components/my_sprite_component/my_sprite_component.dart';
import 'package:color_puzzle/app/module/game/components/my_sprite_component/tap_original_size.dart';
import 'package:color_puzzle/generated/assets_flame_images.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';

import '../components/blackjack/Deck.dart';
import '../components/blackjack/Player.dart';
import '../components/logical_size_component.dart';

import '../components/sprite_with_tap.dart';
import '../game.dart';

class GamePage extends LogicalSizeComponent<AppGame> with TapCallbacks {
  Sprite getSprite(String name) {
    return Sprite(Flame.images.fromCache(name));
  }

  String getHandImageByColor() {
    switch (game.colorId) {
      case 0:
        return AssetsFlameImages.Group_2033;
      case 1:
        return AssetsFlameImages.Group_2035;
      case 2:
        return AssetsFlameImages.Group_2036;
      case 3:
        return AssetsFlameImages.Group_2037;
      case 4:
        return AssetsFlameImages.Group_2038;
      case 5:
        return AssetsFlameImages.Group_2039;
    }
    return AssetsFlameImages.Group_2033;
  }

  @override
  AppGame get game => findGame()! as AppGame;

  int score = 0;

  var scoreComponent = TextComponent(
    text: 0.toString(),
    anchor: Anchor.center,
    textRenderer: TextPaint(
      style: const TextStyle(
          fontSize: 70, color: Colors.white, fontWeight: FontWeight.w700),
    ),
  );
  Player player = Player();
  Dealer dealer = Dealer();
  final Deck deck = Deck();
  List<OriginalSizeLogicSpriteComponent> get playerCards {
    const double cardSpacing = 20.0; // Adjust the spacing between cards.
    double startX = game.canvasSize.x / 2 -
        ((player.hand.cards.length - 1) * cardSpacing) / 2; // Center the cards.

    return player.hand.cards.asMap().entries.map((entry) {
      int index = entry.key;
      var card = entry.value;

      return OriginalSizeLogicSpriteComponent(
        sprite: Sprite(Flame.images.fromCache(card.imagePath)),
        position: Vector2(startX + index * cardSpacing,
            game.canvasSize.y - 200), // Adjust y-coordinate as needed.
      );
    }).toList();
  }

  var playerCardsList = <OriginalSizeLogicSpriteComponent>[];

  @override
  Future<void> onLoad() async {
    deck.shuffle();

    size = game.canvasSize;

    var hand = OriginalSizeLogicSpriteComponent(
        anchor: Anchor.center,
        position: Vector2(0, game.canvasSize.y / 2),
        sprite: getSprite(getHandImageByColor()));
    var hitComponent = OriginalSpriteWithTap(
        anchor: Anchor.bottomLeft,
        position: Vector2(0, game.canvasSize.y),
        onTap: () {
          playerCardsList.add()
          player.hit(deck.dealCard());
          if (dealer.shouldHit()) {
            dealer.hit(deck.dealCard());
          }
        },
        sprite: getSprite(AssetsFlameImages.Frame_5_1));
    var hitInactiveImage = AssetsFlameImages.Frame_5_2;
    var stantdComponent = OriginalSpriteWithTap(
        anchor: Anchor.bottomRight,
        position: game.canvasSize,
        sprite: getSprite(AssetsFlameImages.Frame_10),
        onTap: () {});
    var stantdImageinactive = AssetsFlameImages.Frame_10_1;

    scoreComponent.position = Vector2(
        game.size.x / 2, game.size.y / 2 + LogicalSize.logicalHight(120));

    final imageBg = Flame.images.fromCache(AssetsFlameImages.img_10081453_1);
    final settingImage = Flame.images.fromCache(AssetsFlameImages.Frame);

    var bg = SpriteComponent(
      size: game.canvasSize,
      sprite: Sprite(
        imageBg,
      ),
    );

    addAll([
      bg,
      OriginalSizeLogicSpriteComponent(
          anchor: Anchor.center,
          position: Vector2(game.canvasSize.x / 2, logicalHeight(200)),
          sprite: getSprite(AssetsFlameImages.Frame_1)),
      SpriteWithTap(
        anchor: Anchor.topLeft,
        size: LogicalSize.logicalSizeCircle(160),
        position: LogicalSize.logicalSize(40, 40),
        sprite: Sprite(
          settingImage,
        ),
        onTap: () {
          game.router.pushNamed('settings');
        },
      ),
      scoreComponent,
      hitComponent,
      stantdComponent,
      hand..position.x = LogicalSize.logicalWidth(200),
    ]);
  }

  int elapsedSecs = 0;

  gameOver() {
    score = 0;
    game.router.pushNamed('game_over');
  }

  void changeScore(int value) {
    final newScore = score + value;
    if (newScore < 30) {
      score = 30;
    } else {
      score = newScore;
    }
  }
}
