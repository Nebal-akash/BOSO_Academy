import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/devto_article.dart';

class NewsFeedProvider {
  static Future<List<DevToArticle>> fetchDevToArticles() async {
    final response = await http.get(Uri.parse("https://dev.to/api/articles?per_page=10"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((article) => DevToArticle.fromJson(article)).toList();
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
