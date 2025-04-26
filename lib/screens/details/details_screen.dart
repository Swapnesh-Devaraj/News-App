import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/news_model.dart';

class DetailsScreen extends StatelessWidget {
  final NewsModel news;

  const DetailsScreen({super.key, required this.news});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(news.url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch ${news.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full screen image with PhotoView
          Hero(
            tag: 'news_image_${news.id}',
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(news.imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
          ),
          // Back button overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
