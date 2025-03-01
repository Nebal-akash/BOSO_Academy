import 'package:flutter/material.dart';
import '../services/wikipedia_service.dart';

class LearnScreen extends StatefulWidget {
  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  String _summary = "Search for a topic to learn more!";
  String _aiAnswer = "";
  bool _isLoadingSummary = false;
  bool _isLoadingAI = false;

  final WikipediaService _wikiService = WikipediaService();

  void _searchTopic() async {
    String topic = _searchController.text.trim();
    if (topic.isEmpty) return;

    setState(() => _isLoadingSummary = true);

    String? summary = await _wikiService.fetchSummary(topic);

    setState(() {
      _summary = summary ?? "No summary available.";
      _isLoadingSummary = false;
    });
  }

  void _askAI() async {
    String question = _questionController.text.trim();
    if (question.isEmpty) return;

    setState(() => _isLoadingAI = true);

    String? aiResponse = await _wikiService.fetchAIAnswer(question);

    setState(() {
      _aiAnswer = aiResponse ?? "No relevant information found.";
      _isLoadingAI = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Learn"), backgroundColor: Colors.deepPurpleAccent),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search a topic...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.deepPurple),
                  onPressed: _searchTopic,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            _isLoadingSummary
                ? CircularProgressIndicator(color: Colors.deepPurpleAccent)
                : Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _summary,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _questionController.clear();
                          setState(() {
                            _aiAnswer = "";
                          });
                        },
                        child: Text("Ask AI a Question"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        hintText: "Ask a question...",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send, color: Colors.deepPurple),
                          onPressed: _askAI,
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    _isLoadingAI
                        ? CircularProgressIndicator(color: Colors.deepPurpleAccent)
                        : Text(
                      _aiAnswer,
                      style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
