import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences implements SharedPreferences {
  final Map<String, Object> _storage = {};

  @override
  Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }

  @override
  String? getString(String key) => _storage[key] as String?;

  @override
  Future<bool> setInt(String key, int value) async {
    _storage[key] = value;
    return true;
  }

  @override
  int? getInt(String key) => _storage[key] as int?;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('NewsRepository', () {
    late NewsRepository repository;
    late MockSharedPreferences prefs;

    setUp(() {
      prefs = MockSharedPreferences();
      repository = NewsRepository(prefs);
    });

    test('should cache and retrieve news', () async {
      final newsList = [
        const NewsModel(
          id: '1',
          title: 'Test News',
          description: 'Desc',
          imageUrl: '',
          publishedAt: '',
          source: 'Test',
          url: '',
        ),
      ];
      repository.cacheNews(newsList);
      final cached = repository.getCachedNews();
      expect(cached, isNotNull);
      expect(cached!.first.title, 'Test News');
    });
  });
}
