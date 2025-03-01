import 'package:flutter/material.dart';
import '../providers/newsfeed_provider.dart';
import '../models/devto_article.dart';
import 'package:url_launcher/url_launcher.dart';

class Newsfeed extends StatefulWidget {
  @override
  _NewsfeedState createState() => _NewsfeedState();
}

class _NewsfeedState extends State<Newsfeed> {
  late Future<List<DevToArticle>> articlesFuture;

  @override
  void initState() {
    super.initState();
    articlesFuture = NewsFeedProvider.fetchDevToArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tech & AI News")),
      body: FutureBuilder<List<DevToArticle>>(
        future: articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load articles"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No articles found"));
          }

          final articles = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.network(article.coverImage, width:150, height: 750, fit: BoxFit.cover),
                  title: Text(article.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("By ${article.author} • ${article.publishedAt.substring(0, 10)}"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () async {
                    final url = Uri.parse(article.url);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
