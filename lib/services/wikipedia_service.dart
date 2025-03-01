import 'dart:convert';
import 'package:http/http.dart' as http;

class WikipediaService {
  final String backendUrl = "http://YOUR_FLASK_SERVER_IP:5000"; // Update with your Flask server IP

  // Fetch Wikipedia summary
  Future<String?> fetchSummary(String topic) async {
    final url = Uri.parse(
        "https://en.wikipedia.org/api/rest_v1/page/summary/${Uri.encodeComponent(topic)}");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["extract"] ?? "No summary available.";
      }
    } catch (e) {
      return "Error fetching Wikipedia data.";
    }
    return null;
  }

  // AI-Powered Q&A using Wikipedia + LLaMA 2 (local model)
  Future<String?> fetchAIAnswer(String question) async {
    String? wikipediaSummary = await fetchSummary(question);
    if (wikipediaSummary == null) return "No relevant information found.";

    final aiUrl = Uri.parse("$backendUrl/ask");
    final response = await http.post(
      aiUrl,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "text": wikipediaSummary, // Pass Wikipedia summary as context
        "question": question // User's question
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["answer"].toString();
    } else {
      return "Error fetching AI response.";
    }
  }
}
