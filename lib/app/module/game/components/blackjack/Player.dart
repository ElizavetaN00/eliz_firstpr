import 'Hand.dart';
import 'Card.dart';

class Player {
  final Hand hand = Hand();

  Player();

  void hit(Card card) {
    hand.addCard(card);
  }

  int get score => hand.calculateScore();
}
