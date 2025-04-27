import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API Configuration
///
/// This file should never be committed to version control.
/// See api_config.template.dart for setup instructions.
class ApiConfig {
  /// Base URL for the News API
  static const String baseUrl = 'https://api.thenewsapi.com/v1/news';

  /// Get API key from environment variables
  ///
  /// The API key should be set in the .env file as NEWS_API_KEY=your_key_here
  static String get apiKey {
    final key = dotenv.env['NEWS_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception(
        'API key not found. Please create a .env file with NEWS_API_KEY=your_key_here',
      );
    }
    return key;
  }
}
