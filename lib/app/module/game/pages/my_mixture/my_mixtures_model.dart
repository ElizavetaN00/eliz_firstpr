import '../cards/cards_model.dart';

class MyMixturesModel {
  MyMixturesModel({required this.name, required this.cardsList});
  String name;
  List<CardModel> cardsList;

  static MyMixturesModel fromStorage(Map<String, dynamic> data) {
    var name = data['name'];
    var cardsListString = data['cardsList'];
    return MyMixturesModel(
      name: name,
      cardsList: cardList.where((element) => cardsListString.contains(element.id)).toList(),
    );
  }

  Map<String, dynamic> toStorage() {
    return {
      'name': name,
      'cardsList': cardsList.map((e) => e.id).toList(),
    };
  }
}
