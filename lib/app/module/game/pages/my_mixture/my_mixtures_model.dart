import '../../../../../data/storage/storage.dart';
import '../cards/cards_model.dart';

class MyMixturesModel {
  MyMixturesModel(
      {required this.name, required this.cardsList, String? idTime}) {
    id = idTime ?? DateTime.now().millisecondsSinceEpoch.toString();
  }
  late String id;
  String name;
  List<CardModel> cardsList;

  static MyMixturesModel fromStorage(Map<String, dynamic> data) {
    var name = data['name'];
    var cardsListString = data['cardsList'];
    return MyMixturesModel(
      idTime: data['id'],
      name: name,
      cardsList: cardList
          .where((element) => cardsListString.contains(element.id))
          .toList(),
    );
  }

  Map<String, dynamic> toStorage() {
    return {
      'id': id,
      'name': name,
      'cardsList': cardsList.map((e) => e.id).toList(),
    };
  }

  removeFromStorage() {
    AppStorage.myMixtures.val = AppStorage.myMixtures.val
        .where((element) => element['id'] != id)
        .toList();
  }
}
