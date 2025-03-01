class DevToArticle {
  final String title;
  final String url;
  final String coverImage;
  final String publishedAt;
  final String author;

  DevToArticle({
    required this.title,
    required this.url,
    required this.coverImage,
    required this.publishedAt,
    required this.author,
  });

  factory DevToArticle.fromJson(Map<String, dynamic> json) {
    return DevToArticle(
      title: json['title'],
      url: json['url'],
      coverImage: json['cover_image'] ?? "https://via.placeholder.com/150",
      publishedAt: json['published_at'],
      author: json['user']['name'],
    );
  }
}
