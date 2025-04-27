import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/news_model.dart';
import '../details/photoview.dart';
import '../../config/app_constants.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({required this.news, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoViewScreen(news: news),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: '${AppConstants.newsCardHeroTagPrefix}${news.id}',
                child: CachedNetworkImage(
                  imageUrl: news.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade100,
                          Colors.blue.shade50,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.newspaper_rounded,
                            size: 48,
                            color: Colors.blue.shade300,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppConstants.newsCardImageNotAvailable,
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: AppConstants.newsCardSourceFontSize,
                              fontWeight: AppConstants.newsCardTitleFontWeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: AppConstants.newsCardTitleFontWeight,
                      fontSize: AppConstants.newsCardTitleFontSize,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    news.source,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: AppConstants.newsCardSourceFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
