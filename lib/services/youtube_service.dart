import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeVideo {
  final String title;
  final String videoUrl;
  final String thumbnailUrl;
  final String channelName;

  YouTubeVideo({
    required this.title,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.channelName,
  });

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    return YouTubeVideo(
      title: json['snippet']['title'],
      videoUrl: "https://www.youtube.com/watch?v=${json['id']['videoId']}",
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
      channelName: json['snippet']['channelTitle'],
    );
  }
}

class YouTubeService {
  static const String _apiKey = "AIzaSyDjmilnM4_M2eApBfBwEBv4cZBnnV7CUJg";  // Replace with your API key
  static const String _baseUrl = "https://www.googleapis.com/youtube/v3/search";

  Future<List<YouTubeVideo>> fetchYouTubeCourses(String query) async {
    final url = Uri.parse("$_baseUrl?part=snippet&q=$query&type=video&maxResults=10&key=$_apiKey");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List videos = data['items'];

      return videos.map((video) => YouTubeVideo.fromJson(video)).toList();
    } else {
      throw Exception("Failed to load YouTube courses");
    }
  }
}
