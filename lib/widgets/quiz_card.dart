import 'package:flutter/material.dart';
import '../models/quiz_model.dart';

class QuizCard extends StatelessWidget {
  final QuizQuestion question;

  QuizCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade700,
      child: ListTile(
        title: Text(question.question, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
