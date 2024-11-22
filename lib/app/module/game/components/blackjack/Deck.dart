import 'Card.dart';
import 'dart:math';

class Deck {
  final List<Card> _cards = [];

  Deck() {
    _initializeDeck();
    shuffle();
  }

  List<String> clubsImages = List.generate(13, (index) {
    var zeroPrefix = index < 9 ? "0" : "";
    return "$zeroPrefix${index + 1}.png";
  });

  List<String> spidersImages = List.generate(13, (index) {
    return "${index + 14}.png";
  });

  List<String> heartsImages = List.generate(13, (index) {
    return "${index + 27}.png";
  });

  List<String> diamondsImages = List.generate(13, (index) {
    return "${index + 40}.png";
  });

  void _initializeDeck() {
    const suits = ["Hearts", "Diamonds", "Clubs", "Spades"];
    const ranks = [
      {"rank": "A", "value": 11},
      {"rank": "2", "value": 2},
      {"rank": "3", "value": 3},
      {"rank": "4", "value": 4},
      {"rank": "5", "value": 5},
      {"rank": "6", "value": 6},
      {"rank": "7", "value": 7},
      {"rank": "8", "value": 8},
      {"rank": "9", "value": 9},
      {"rank": "10", "value": 10},
      {"rank": "J", "value": 10},
      {"rank": "Q", "value": 10},
      {"rank": "K", "value": 10},
    ];

    for (var suit in suits) {
      for (var rank in ranks) {
        var imagePath = "";
        switch (suit) {
          case "Hearts":
            imagePath = heartsImages[ranks.indexOf(rank)];
            break;
          case "Diamonds":
            imagePath = diamondsImages[ranks.indexOf(rank)];
            break;
          case "Clubs":
            imagePath = clubsImages[ranks.indexOf(rank)];
            break;
          case "Spades":
            imagePath = spidersImages[ranks.indexOf(rank)];
            break;
        }

        _cards.add(Card(
            suit, rank['rank'] as String, rank['value'] as int, imagePath));
      }
    }
  }

  void shuffle() {
    _cards.shuffle(Random());
  }

  Card dealCard() {
    if (_cards.isEmpty) {
      throw Exception("Deck is empty!");
    }
    return _cards.removeLast();
  }
}
