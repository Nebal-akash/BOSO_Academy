import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nebal/models/quiz_model.dart';

class QuizService {
  static const String _baseUrl = "http://127.0.0.1:5001"; // Backend base URL
  static const String _quizEndpoint = "/generate_quiz"; // API endpoint

  Future<List<QuizQuestion>> fetchQuiz(String topic, int numQuestions) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl$_quizEndpoint"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "topic": topic,
          "num_questions": numQuestions,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['quiz'] != null) {
          return (data['quiz'] as List).map((item) {
            return QuizQuestion(
              question: item['question'],
              options: List<String>.from(item['options']),
              answer: item['answer'],
            );
          }).toList();
        } else {
          throw Exception("Invalid API response: Missing 'quiz' data.");
        }
      } else {
        throw Exception("Failed to generate quiz: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error in fetchQuiz: $e");
    }
  }
}
