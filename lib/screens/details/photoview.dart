import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:ui';

import '../../models/news_model.dart';

class PhotoViewScreen extends StatelessWidget {
  final NewsModel news;

  const PhotoViewScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: news.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.black),
              errorWidget: (context, url, error) =>
                  Container(color: Colors.black),
            ),
          ),
          // Blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.black.withAlpha(77), // 0.3 opacity = 77/255
              ),
            ),
          ),
          // Full screen image with PhotoView
          Hero(
            tag: 'news_image_${news.id}',
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(news.imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
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
