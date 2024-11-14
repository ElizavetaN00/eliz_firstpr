import 'dart:math';

extension RandomElementsFromList<T> on List<T> {
  List<T> getRandomElements(int count) {
    final random = Random();
    final List<T> randomElements = [];

    // Создаем копию списка, чтобы случайные элементы не повторялись
    final List<T> tempList = List.from(this);

    for (int i = 0; i < count && tempList.isNotEmpty; i++) {
      // Выбираем случайный индекс
      int randomIndex = random.nextInt(tempList.length);
      // Добавляем случайный элемент в результат
      randomElements.add(tempList[randomIndex]);
      // Удаляем элемент из временного списка, чтобы избежать повторений
      tempList.removeAt(randomIndex);
    }

    return randomElements;
  }
}
