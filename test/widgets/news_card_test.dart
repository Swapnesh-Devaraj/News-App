import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/screens/listing/news_card.dart';
import 'package:news_app/models/news_model.dart';

void main() {
  group('NewsCard Widget Tests', () {
    testWidgets('displays news title and source', (WidgetTester tester) async {
      const news = NewsModel(
        id: '1',
        title: 'Test News Title',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        source: 'Test Source',
        publishedAt: '2024-01-01',
        url: 'https://example.com',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NewsCard(news: news),
          ),
        ),
      );

      expect(find.text('Test News Title'), findsOneWidget);
      expect(find.text('Test Source'), findsOneWidget);
    });

    testWidgets('displays loading indicator while image loads',
        (WidgetTester tester) async {
      const news = NewsModel(
        id: '1',
        title: 'Test News Title',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        source: 'Test Source',
        publishedAt: '2024-01-01',
        url: 'https://example.com',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NewsCard(news: news),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error icon when image fails to load',
        (WidgetTester tester) async {
      const news = NewsModel(
        id: '1',
        title: 'Test News Title',
        description: 'Test Description',
        imageUrl: 'invalid_url',
        source: 'Test Source',
        publishedAt: '2024-01-01',
        url: 'https://example.com',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NewsCard(news: news),
          ),
        ),
      );

      // Wait for the error widget to appear
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.error), findsOneWidget);
    }, skip: true);
  });
}
