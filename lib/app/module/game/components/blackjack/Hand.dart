
import 'Card.dart';

class Hand {
  final List<Card> _cards = [];

  void addCard(Card card) {
    _cards.add(card);
  }

  int calculateScore() {
    int score = 0;
    int aceCount = 0;

    for (var card in _cards) {
      score += card.value;
      if (card.rank == "A") aceCount++;
    }

    while (score > 21 && aceCount > 0) {
      score -= 10;
      aceCount--;
    }

    return score;
  }

  List<Card> get cards => List.unmodifiable(_cards);
}
