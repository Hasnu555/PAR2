import 'package:derviza_app/screen/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:derviza_app/model/article.dart';
void main() {
  testWidgets('ArticleListItem Widget Test', (WidgetTester tester) async {
    // Create a test Article object
    final Article testArticle = Article(
      author: 'John Doe',
      article: 'Sample article content',
      title: 'Sample Article',
      index: 1,
    );

    // Build our widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ArticleListItem(article: testArticle),
        ),
      ),
    );

    // Find elements by text
    final titleFinder = find.text('Sample Article');
    final authorFinder = find.text('Author: John Doe');
    final articleFinder = find.text('Sample article content');

    // Verify that the widgets are displayed correctly
    expect(titleFinder, findsOneWidget);
    expect(authorFinder, findsOneWidget);
    expect(articleFinder, findsOneWidget);
  });
}
