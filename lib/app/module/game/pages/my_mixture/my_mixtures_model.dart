import '../cards/cards_model.dart';

class MyMixturesModel {
  MyMixturesModel({required this.name, required this.cardsList});
  String name;
  List<CardModel> cardsList;

  static MyMixturesModel fromStorage(Map<String, dynamic> data) {
    var name = data['name'];
    var cardsListInts = (data['cardsList'] as List<String>);
    return MyMixturesModel(
      name: name,
      cardsList: cardList.where((element) => cardsListInts.contains(element.id)).toList(),
    );
  }

  toStorage() {
    return {
      'name': name,
      'cardsList': cardsList.map((e) => e.id).toList(),
    };
  }
}
