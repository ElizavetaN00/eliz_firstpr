import 'package:color_puzzle/app/module/game/game.dart';
import 'package:color_puzzle/app/module/game/pages/game_over_page.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class GameOverRoute extends ValueRoute<bool> with HasGameRef<AppGame> {
  GameOverRoute({required super.value, super.transparent = true});

  @override
  void onPush(Route? previousRoute) {
    previousRoute!.stopTime();
  }

  @override
  void onPop(Route nextRoute) {
    nextRoute
      ..resumeTime()
      ..removeRenderEffect();
  }

  GameOverPage getPage() {
    if (game.userScore > 21) {
      return GameOverPage.loss(); // Игрок проиграл, если набрал больше 21
    } else if (game.dealerScore > 21) {
      return GameOverPage
          .victory(); // Игрок победил, если дилер набрал больше 21
    } else if (game.userScore > game.dealerScore) {
      return GameOverPage
          .victory(); // Игрок победил, если его очки больше очков дилера
    } else if (game.userScore == game.dealerScore) {
      return GameOverPage.draw(); // Ничья, если очки равны
    } else {
      return GameOverPage.loss(); // В остальных случаях игрок проиграл
    }
  }

  @override
  Component build() {
    return getPage();
  }
}
