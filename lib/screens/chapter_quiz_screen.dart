import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../widgets/quiz_card.dart';

class ChapterQuizScreen extends StatelessWidget {
  final List<QuizQuestion> sampleQuiz = [
    QuizQuestion(
      question: "What is Flutter?",
      options: ["A programming language", "A framework", "A database", "An IDE"],
      answer: "A framework",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Chapter Quiz"), backgroundColor: Colors.deepPurpleAccent),
      body: ListView.builder(
        itemCount: sampleQuiz.length,
        itemBuilder: (context, index) => QuizCard(question: sampleQuiz[index]),
      ),
    );
  }
}
