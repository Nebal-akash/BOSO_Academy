import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../services/quiz_service.dart';
import '../widgets/quiz_card.dart';

class AIQuizScreen extends StatefulWidget {
  @override
  _AIQuizScreenState createState() => _AIQuizScreenState();
}

class _AIQuizScreenState extends State<AIQuizScreen> {
  final TextEditingController _topicController = TextEditingController();
  final QuizService _quizService = QuizService();
  bool _isLoading = false;
  List<QuizQuestion> _quizQuestions = [];

  void _fetchQuiz() async {
    setState(() => _isLoading = true);

    List<QuizQuestion> questions = await _quizService.fetchQuiz(_topicController.text, 5);

    setState(() {
      _quizQuestions = questions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("AI-Generated Quiz"), backgroundColor: Colors.deepPurpleAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _topicController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Topic",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator(color: Colors.deepPurpleAccent)
                : ElevatedButton(
              onPressed: _fetchQuiz,
              child: Text("Generate Quiz"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _quizQuestions.length,
                itemBuilder: (context, index) => QuizCard(question: _quizQuestions[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
