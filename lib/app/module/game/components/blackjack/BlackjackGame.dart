import 'Deck.dart';
import 'Player.dart';
import 'Dealer.dart';

class BlackjackGame {
  final Deck deck = Deck();
  final Player player;
  final Dealer dealer = Dealer();

  BlackjackGame(String playerName) : player = Player(playerName);

  String playerTurn(String action) {
    if (action == "hit") {
      player.hit(deck.dealCard());
      if (player.score > 21) {
        return "Bust! You lose.";
      }
    } else if (action == "stand") {
      return "Player stands.";
    }
    return "Player score: ${player.score}";
  }

  String dealerTurn() {
    while (dealer.shouldHit()) {
      dealer.hit(deck.dealCard());
    }
    if (dealer.score > 21) {
      return "Dealer busts! You win.";
    }
    return "Dealer stands with score: ${dealer.score}";
  }

  String determineWinner() {
    if (player.score > 21) return "Dealer wins!";
    if (dealer.score > 21) return "Player wins!";
    if (player.score > dealer.score) return "Player wins!";
    if (player.score < dealer.score) return "Dealer wins!";
    return "It's a tie!";
  }
}
