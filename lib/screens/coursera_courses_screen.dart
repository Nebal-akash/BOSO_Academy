import 'package:flutter/material.dart';
import '../services/coursera_service.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseraCoursesScreen extends StatefulWidget {
  @override
  _CourseraCoursesScreenState createState() => _CourseraCoursesScreenState();
}

class _CourseraCoursesScreenState extends State<CourseraCoursesScreen> {
  late Future<List<Map<String, String>>> _coursesFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _allCourses = [];
  List<Map<String, String>> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  void _fetchCourses() {
    _coursesFuture = CourseraService().fetchCourses();
    _coursesFuture.then((courses) {
      setState(() {
        _allCourses = courses;
        _filteredCourses = courses;
      });
    });
  }

  void _filterCourses(String query) {
    setState(() {
      _filteredCourses = _allCourses
          .where((course) =>
          course["title"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coursera Courses"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCourses,
              decoration: InputDecoration(
                hintText: "Search courses...",
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),

          // Course List
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
              future: _coursesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child:
                      CircularProgressIndicator(color: Colors.deepPurple));
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text("Error: ${snapshot.error}",
                          style: TextStyle(color: Colors.red)));
                } else if (_filteredCourses.isEmpty) {
                  return Center(
                      child: Text("No courses found.",
                          style: TextStyle(color: Colors.white)));
                }

                return ListView.builder(
                  itemCount: _filteredCourses.length,
                  itemBuilder: (context, index) {
                    final course = _filteredCourses[index];
                    return Card(
                      color: Colors.white10,
                      margin:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8),
                        leading: course["image"]!.isNotEmpty
                            ? Image.network(course["image"]!,
                            width: 80, height: 60, fit: BoxFit.cover)
                            : Icon(Icons.school, color: Colors.white),
                        title: Text(course["title"]!,
                            style:
                            TextStyle(color: Colors.white, fontSize: 16)),
                        subtitle: Text(
                          course["description"] ?? "No description available",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70),
                        ),
                        onTap: () => _launchURL(course["url"]!),
                        trailing: Icon(Icons.open_in_new,
                            color: Colors.deepPurpleAccent),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
