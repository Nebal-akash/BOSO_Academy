import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebal/services/quiz_service.dart';
import 'package:nebal/models/quiz_model.dart';

class PracticeScreen extends StatefulWidget {
  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _topicController = TextEditingController();
  bool _isLoading = false;
  bool _hasError = false;
  List<QuizQuestion> _quizQuestions = [];
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  int _score = 0;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _topicController.dispose();
    super.dispose();
  }

  Future<void> _generateQuiz() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _quizQuestions = [];
      _currentQuestionIndex = 0;
      _selectedAnswer = null;
      _score = 0;
      _showResult = false;
    });

    try {
      QuizService quizService = QuizService();
      List<QuizQuestion> quiz = await quizService.fetchQuiz(_topicController.text, 5);

      setState(() {
        _quizQuestions = quiz;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _nextQuestion() {
    if (_selectedAnswer == _quizQuestions[_currentQuestionIndex].answer) {
      _score++;
    }

    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      });
    } else {
      setState(() {
        _showResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Practice"),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.menu_book), text: "Chapter Quiz"),
            Tab(icon: Icon(FontAwesomeIcons.users), text: "Peer Challenge"),
            Tab(icon: Icon(Icons.smart_toy), text: "AI Quiz"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChapterQuiz(),
          _buildPeerChallenge(),
          _buildAIQuiz(),
        ],
      ),
    );
  }

  Widget _buildChapterQuiz() {
    return Center(
      child: Text("📚 Chapter Quiz Section Coming Soon!", style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }

  Widget _buildPeerChallenge() {
    return Center(
      child: Text("🎮 Peer Challenge Section Coming Soon!", style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }

  Widget _buildAIQuiz() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("🤖 Enter a Topic for AI-Generated Quiz", style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(height: 20),
          TextField(
            controller: _topicController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white24,
              hintText: "Type a topic (e.g., Machine Learning)",
              hintStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: 20),
          _isLoading
              ? CircularProgressIndicator(color: Colors.deepPurpleAccent)
              : ElevatedButton(
            onPressed: _generateQuiz,
            child: Text("Generate Quiz"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: 20),
          if (_hasError)
            Text("⚠️ Failed to fetch quiz. Please try again.", style: TextStyle(color: Colors.red, fontSize: 16)),
          _quizQuestions.isNotEmpty ? _showResult ? _buildResultView() : _buildQuizView() : Container(),
        ],
      ),
    );
  }

  Widget _buildQuizView() {
    QuizQuestion currentQuestion = _quizQuestions[_currentQuestionIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Question ${_currentQuestionIndex + 1}: ${currentQuestion.question}",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...currentQuestion.options.map((option) => GestureDetector(
          onTap: _selectedAnswer == null
              ? () {
            setState(() {
              _selectedAnswer = option;
            });
          }
              : null,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _selectedAnswer == null
                  ? Colors.white24
                  : option == currentQuestion.answer
                  ? Colors.green
                  : (_selectedAnswer == option ? Colors.red : Colors.white24),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(option, style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        )),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _selectedAnswer != null ? _nextQuestion : null,
          child: Text("Next Question"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    return Column(
      children: [
        Text("🎉 Quiz Completed!", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("Your Score: $_score / ${_quizQuestions.length}", style: TextStyle(color: Colors.green, fontSize: 18)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _generateQuiz,
          child: Text("Try Again"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
        ),
      ],
    );
  }
}
