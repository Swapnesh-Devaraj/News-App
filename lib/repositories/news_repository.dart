import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/news_model.dart';
import '../config/api_config.dart';

class NewsResponse {
  final List<NewsModel> news;
  final int totalFound;
  final bool hasLimitWarning;

  NewsResponse({
    required this.news,
    required this.totalFound,
    required this.hasLimitWarning,
  });
}

class NewsRepository {
  final SharedPreferences prefs;
  static const String _cacheKey = 'news_cache';
  static const Duration _cacheDuration = Duration(minutes: 15);

  NewsRepository(this.prefs);

  Future<NewsResponse> _fetchNewsFromApi(
      {required int page, required int pageSize}) async {
    final apiKey = ApiConfig.apiKey;
    if (apiKey.isEmpty) {
      throw Exception(
          'API key not found. Please set the NEWS_API_KEY environment variable.');
    }
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/all?api_token=$apiKey&page=$page&limit=$pageSize'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final news = (data['data'] as List)
          .map((item) => NewsModel.fromJson(item))
          .toList();
      final meta = data['meta'] as Map<String, dynamic>;
      final totalFound = meta['found'] as int;
      final warnings = data['warnings'] as List?;
      final hasLimitWarning = warnings?.any((warning) => warning
              .toString()
              .contains('limit is higher than your plan allows')) ??
          false;
      return NewsResponse(
        news: news,
        totalFound: totalFound,
        hasLimitWarning: hasLimitWarning,
      );
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<NewsResponse> getNews({int page = 0, int pageSize = 20}) async {
    try {
      final newsResponse =
          await _fetchNewsFromApi(page: page, pageSize: pageSize);
      return newsResponse;
    } catch (e) {
      final cachedData = getCachedNews();
      if (cachedData != null) {
        return NewsResponse(
          news: cachedData,
          totalFound: cachedData.length,
          hasLimitWarning: false,
        );
      }
      throw Exception('Failed to load news: $e');
    }
  }

  List<NewsModel>? getCachedNews() {
    final cachedString = prefs.getString(_cacheKey);
    if (cachedString != null) {
      final cachedTime = prefs.getInt('${_cacheKey}_time');
      if (cachedTime != null) {
        final cacheAge = DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch(cachedTime));
        if (cacheAge < _cacheDuration) {
          final List<dynamic> decoded = json.decode(cachedString);
          return decoded.map((item) => NewsModel.fromJson(item)).toList();
        }
      }
    }
    return null;
  }

  void cacheNews(List<NewsModel> news) {
    final encoded = json.encode(news.map((e) => e.toJson()).toList());
    prefs.setString(_cacheKey, encoded);
    prefs.setInt('${_cacheKey}_time', DateTime.now().millisecondsSinceEpoch);
  }

  /// Returns cached news instantly if available (for page 1), then fetches fresh news and updates the cache.
  Stream<NewsResponse> getNewsWithCacheFirst(
      {int page = 1, int pageSize = 20}) async* {
    if (page == 1) {
      final cached = getCachedNews();
      if (cached != null && cached.isNotEmpty) {
        yield NewsResponse(
          news: cached,
          totalFound: cached.length,
          hasLimitWarning: false,
        );
      }
    }
    try {
      final newsResponse =
          await _fetchNewsFromApi(page: page, pageSize: pageSize);
      if (page == 1) {
        cacheNews(newsResponse.news);
      }
      yield newsResponse;
    } catch (e) {
      if (page == 1) {
        final cached = getCachedNews();
        if (cached != null && cached.isNotEmpty) {
          yield NewsResponse(
            news: cached,
            totalFound: cached.length,
            hasLimitWarning: false,
          );
          return;
        }
      }
      throw Exception('Failed to load news: $e');
    }
  }
}
