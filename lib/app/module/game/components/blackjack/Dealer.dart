
import 'Hand.dart';
import 'Card.dart';

class Dealer {
  final Hand hand = Hand();

  void hit(Card card) {
    hand.addCard(card);
  }

  int get score => hand.calculateScore();

  bool shouldHit() {
    return score < 17;
  }
}
