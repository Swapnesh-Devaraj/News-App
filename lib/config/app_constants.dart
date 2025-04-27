import 'package:flutter/material.dart';

class AppConstants {
  // AppBar
  static const String appTitleNews = 'News';
  static const String appTitleApp = 'App';

  // Colors
  static const Color appBarIconColor = Colors.blue;
  static const Color appBarTextColor = Colors.black87;
  static const Color appBarTextBlue = Colors.blue;
  static const Color appBarBackground = Colors.white;

  // NewsCard
  static const double newsCardTitleFontSize = 14;
  static const double newsCardSourceFontSize = 12;
  static const FontWeight newsCardTitleFontWeight = FontWeight.bold;
  static const String newsCardImageNotAvailable = 'Image not available';
  static const String newsCardHeroTagPrefix = 'news_image_';

  // PhotoViewScreen
  static const int blurAlpha = 77; // 0.3 opacity = 77/255
  static const Color photoViewBackground = Colors.transparent;

  // Others
  static const int shimmerCardCount = 6;
}
