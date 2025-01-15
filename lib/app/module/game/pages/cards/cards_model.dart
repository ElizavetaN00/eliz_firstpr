import 'package:game/data/storage/storage.dart';

class CardModel {
  CardModel({
    required this.id,
  }) {
    stars = AppStorage.getValue(id, 0);
    imagePath = 'assets/images/cards/$id.png';
    if (id.contains('relax')) {
      category = 1;
    } else if (id.contains('energy')) {
      category = 2;
    } else if (id.contains('detox')) {
      category = 3;
    } else {
      category = 4;
    }
  }

  final String id;
  late final String imagePath;
  late int stars;
  late int category;

  setStars(int stars) {
    AppStorage.setValue(id, stars);
    this.stars = stars;
  }
}

var _cardsList1 = List.generate(15, (i) {
  return CardModel(id: 'detox (${i + 1})');
});
var _cardsList2 = List.generate(16, (i) {
  return CardModel(id: 'energy (${i + 1})');
});
var _cardsList3 = List.generate(20, (i) {
  return CardModel(id: 'relax (${i + 1})');
});
var _cardsList4 = List.generate(11, (i) {
  return CardModel(id: 'wellness (${i + 1})');
});

var cardList = _cardsList1 + _cardsList2 + _cardsList3 + _cardsList4;
