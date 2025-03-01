import 'dart:math';

class QuizSystem {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is 2 + 2?",
      "options": ["3", "4", "5", "6"],
      "correctIndex": 1
    },
    {
      "question": "What is the capital of France?",
      "options": ["London", "Berlin", "Paris", "Rome"],
      "correctIndex": 2
    },
  ];

  Map<String, dynamic> getRandomQuestion() {
    return questions[Random().nextInt(questions.length)];
  }
}
