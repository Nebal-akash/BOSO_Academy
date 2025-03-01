import 'dart:convert';
import 'package:http/http.dart' as http;

class CourseraService {
  final String baseUrl = "https://api.coursera.org/api/courses.v1";

  Future<List<Map<String, String>>> fetchCourses() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> courses = data["elements"];

        return courses.map((course) {
          return {
            "title": course["name"]?.toString() ?? "No Title",
            "description": course["description"]?.toString() ?? "No Description",
            "image": course["photoUrl"]?.toString() ?? "",
            "url": "https://www.coursera.org/learn/${course["slug"]?.toString()}"
          };
        }).toList();
      }
    } catch (e) {
      print("Error fetching courses: $e");
    }

    return [];
  }
}
