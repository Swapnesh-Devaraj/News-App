import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String publishedAt;
  final String source;
  final String url;

  const NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['uuid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      publishedAt: json['published_at'] ?? '',
      source: json['source'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'published_at': publishedAt,
      'source': source,
      'url': url,
    };
  }

  @override
  List<Object> get props =>
      [id, title, description, imageUrl, publishedAt, source, url];
}
