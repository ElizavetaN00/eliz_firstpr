class Card {
  final String suit; // Масть: "Hearts", "Diamonds", "Clubs", "Spades"
  final String rank; // Ранг: "2", "3", ..., "K", "A"
  final int value; // Значение: 2–10, 10 для "J", "Q", "K", 11 или 1 для "A"
  final String imagePath;
  Card(this.suit, this.rank, this.value, this.imagePath);
}
