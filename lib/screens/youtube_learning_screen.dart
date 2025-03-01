import 'package:flutter/material.dart';
import 'package:nebal/services/youtube_service.dart';
import 'package:url_launcher/url_launcher.dart';

class YouTubeLearningScreen extends StatefulWidget {
  @override
  _YouTubeLearningScreenState createState() => _YouTubeLearningScreenState();
}

class _YouTubeLearningScreenState extends State<YouTubeLearningScreen> {
  late Future<List<YouTubeVideo>> _coursesFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCourses("AI Learning");
  }

  void _fetchCourses(String topic) {
    setState(() {
      _coursesFuture = YouTubeService().fetchYouTubeCourses(topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YouTube Learning"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for courses...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _fetchCourses(_searchController.text);
                    }
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.deepPurpleAccent,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<YouTubeVideo>>(
              future: _coursesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No courses found.", style: TextStyle(color: Colors.white)));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final course = snapshot.data![index];
                    return Card(
                      color: Colors.white10,
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8),
                        leading: Image.network(course.thumbnailUrl, width: 100, height: 80, fit: BoxFit.cover),
                        title: Text(course.title, style: TextStyle(color: Colors.white, fontSize: 16)),
                        subtitle: Text("By ${course.channelName}", style: TextStyle(color: Colors.white70)),
                        onTap: () => launchUrl(Uri.parse(course.videoUrl)),
                        trailing: Icon(Icons.play_circle_filled, color: Colors.deepPurpleAccent),
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
}
