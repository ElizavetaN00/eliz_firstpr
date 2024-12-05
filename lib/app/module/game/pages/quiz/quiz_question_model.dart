class QuizQuestionModel {
  final int id;
  final String question;
  final List<String> options;
  final int answer;

  QuizQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });
}

List<QuizQuestionModel> listQuestions = [
  QuizQuestionModel(
    id: 1,
    question: "Which number was first added to roulette to give the casino an advantage?",
    options: ["1", "99", "0", "37"],
    answer: 2, // Index of the correct answer "0"
  ),
  QuizQuestionModel(
    id: 2,
    question: "How many cards were used in a poker deck before the mid-19th century?",
    options: ["52 cards", "36 cards", "20 cards", "48 cards"],
    answer: 2, // Index of the correct answer "20 cards"
  ),
  QuizQuestionModel(
    id: 3,
    question: "What symbols were used in the first slots instead of fruits?",
    options: ["Cards", "Animals", "Numbers", "Bells"],
    answer: 0, // Index of the correct answer "Cards"
  ),
  QuizQuestionModel(
    id: 4,
    question: "Where is one of the oldest casinos in the world, opened in 1638, located?",
    options: ["Las Vegas", "Venice", "Paris", "Monte Carlo"],
    answer: 1, // Index of the correct answer "Venice"
  ),
  QuizQuestionModel(
    id: 5,
    question: "What symbol is considered the most popular in classic slots?",
    options: ["BAR", "Cherry", "7", "Golden Bell"],
    answer: 2, // Index of the correct answer "7"
  ),
  QuizQuestionModel(
    id: 6,
    question: "What was the first game in the video slot category?",
    options: ["Starburst", "Fortune Coin", "Mega Moolah", "Twin Spin"],
    answer: 1, // Index of the correct answer "Fortune Coin"
  ),
  QuizQuestionModel(
    id: 7,
    question: "What word inspired the name 'casino'?",
    options: ["Casa (house)", "Caso (chance)", "Casin (luck)", "Cosa (thing)"],
    answer: 0, // Index of the correct answer "Casa (house)"
  ),
  QuizQuestionModel(
    id: 8,
    question: "Which of these games originated in Ancient Egypt?",
    options: ["Lottery", "Baccarat", "Dice", "Roulette"],
    answer: 2, // Index of the correct answer "Dice"
  ),
  QuizQuestionModel(
    id: 9,
    question: "When was the first slot machine invented?",
    options: ["1829", "1865", "1895", "1910"],
    answer: 2, // Index of the correct answer "1895"
  ),
  QuizQuestionModel(
    id: 10,
    question: "What does RTP stand for in slots?",
    options: ["Return to Player", "Random Turnover Program", "Regular Top Prize", "Risk to Play"],
    answer: 0, // Index of the correct answer "Return to Player"
  ),
];
