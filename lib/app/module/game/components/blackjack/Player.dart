
import 'Hand.dart';
import 'Card.dart';

class Player {
  final String name;
  final Hand hand = Hand();

  Player(this.name);

  void hit(Card card) {
    hand.addCard(card);
  }

  int get score => hand.calculateScore();
}
