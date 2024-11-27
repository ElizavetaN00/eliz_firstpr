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
import '../routes/game_over_route.dart';

class GamePage extends LogicalSizeComponent<AppGame> with TapCallbacks {
  Sprite getSprite(String name) {
    return Sprite(Flame.images.fromCache(name));
  }

  String getDeckImageByColor() {
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

  String getBackImageByColor() {
    switch (game.colorId) {
      case 0:
        return AssetsFlameImages.img_9993296;
      case 1:
        return AssetsFlameImages.img_9993297;
      case 2:
        return AssetsFlameImages.img_9993298;
      case 3:
        return AssetsFlameImages.img_9993299;
      case 4:
        return AssetsFlameImages.img_9993300;
      case 5:
        return AssetsFlameImages.img_9993301;
    }
    return AssetsFlameImages.img_9993296;
  }

  @override
  AppGame get game => findGame()! as AppGame;

  int score = 0;
  Vector2 cardSize = LogicalSize.logicalSize(275, 360);
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
  var playerHandOffsetX = 0;
  var dealerHandOffsetX = 0;

  double startX = 0;
  double startXDealer = 0;

  BackCardComponent getDealerCard() {
    children.whereType<BackCardComponent>().forEach((element) {
      element.position.x -= LogicalSize.logicalWidth(60);
    });
    var card = BackCardComponent(
      anchor: Anchor.center,
      sprite: Sprite(Flame.images.fromCache(getBackImageByColor())),
      size: cardSize,
      position: Vector2(game.canvasSize.x / 2 + startXDealer,
          0 + LogicalSize.logicalHight(600)), // Adjust y-coordinate as needed.
    );

    startXDealer += LogicalSize.logicalWidth(60);
    return card;
  }

  OriginalSizeLogicSpriteComponent getCard(card) {
    children.whereType<CardComponent>().forEach((element) {
      element.position.x -= LogicalSize.logicalWidth(60);
    });

    card = CardComponent(
      anchor: Anchor.center,
      sprite: Sprite(Flame.images.fromCache(card.imagePath)),
      size: cardSize,
      position: Vector2(
          game.canvasSize.x / 2 + startX,
          game.canvasSize.y -
              LogicalSize.logicalHight(600)), // Adjust y-coordinate as needed.
    );
    startX += LogicalSize.logicalWidth(60);

    return (card);
  }

  restart() async {
    player = Player();
    dealer = Dealer();
    deck.shuffle();
    playerHandOffsetX = 0;
    dealerHandOffsetX = 0;
    startX = 0;
    startXDealer = 0;
    score = 0;
    scoreComponent.text = score.toString();

    children.whereType<CardComponent>().forEach((element) {
      remove(element);
    });
    children.whereType<BackCardComponent>().forEach((element) {
      remove(element);
    });
    changeButtons(true);
    hit();
    await Future.delayed(Duration(milliseconds: 100), () {});
    hit();
  }

  dealerHit() async {
    while (dealer.score < 17) {
      dealer.hit(deck.dealCard());
      add(getDealerCard());
      await Future.delayed(Duration(milliseconds: 500));
    }
    gameOver();
  }

  hit() {
    player.hit(deck.dealCard());
    scoreComponent.text = player.score.toString();
    if (player.score > 21) {
      gameOver();
      return;
    }
    add(getCard(player.hand.cards.last));
  }

  changeButtons(bool visible) {
    children
        .where((element) => element.key == ComponentKey.named('hit'))
        .forEach((element) {
      element as OriginalSpriteWithTap;
      element.onTap = visible ? () => hit() : () {};
      element.sprite = getSprite(visible ? hitActiveImage : hitInactiveImage);
    });

    children
        .where((element) => element.key == ComponentKey.named('stand'))
        .forEach((element) {
      element as OriginalSpriteWithTap;
      element.onTap = visible ? () => stand() : () {};
      element.sprite =
          getSprite(visible ? stantdImageactive : stantdImageinactive);
    });
  }

  stand() {
    changeButtons(false);
    dealerHit();
  }

  var hitActiveImage = AssetsFlameImages.Frame_5_1;
  var hitInactiveImage = AssetsFlameImages.Frame_5_2;
  var stantdImageactive = AssetsFlameImages.Frame_10;
  var stantdImageinactive = AssetsFlameImages.Frame_10_1;
  @override
  Future<void> onLoad() async {
    deck.shuffle();

    size = game.canvasSize;

    var hand = OriginalSizeLogicSpriteComponent(
        anchor: Anchor.center,
        position: Vector2(0, game.canvasSize.y / 2),
        sprite: getSprite(getDeckImageByColor()));
    var hitComponent = OriginalSpriteWithTap(
        key: ComponentKey.named('hit'),
        anchor: Anchor.bottomLeft,
        position: Vector2(0, game.canvasSize.y) -
            Vector2(
                -LogicalSize.logicalWidth(80), LogicalSize.logicalHight(80)),
        onTap: () {
          hit();
        },
        sprite: getSprite(AssetsFlameImages.Frame_5_1));
    var stantdComponent = OriginalSpriteWithTap(
        key: ComponentKey.named('stand'),
        anchor: Anchor.bottomRight,
        position: game.canvasSize -
            Vector2(LogicalSize.logicalWidth(80), LogicalSize.logicalHight(80)),
        sprite: getSprite(AssetsFlameImages.Frame_10),
        onTap: () {
          stand();
        });

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
    restart();
  }

  int elapsedSecs = 0;

  gameOver() async {
    await game.router.pushAndWait(GameOverRoute(value: true));
    restart();
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

class CardComponent extends OriginalSizeLogicSpriteComponent {
  CardComponent({
    super.anchor,
    super.position,
    super.sprite,
    super.size,
    super.children,
    super.priority,
  });
}

class BackCardComponent extends OriginalSizeLogicSpriteComponent {
  BackCardComponent({
    super.anchor,
    super.position,
    super.sprite,
    super.size,
    super.children,
    super.priority,
  });
}
