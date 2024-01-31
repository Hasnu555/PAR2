import 'package:derviza_app/model/article.dart';

import 'package:derviza_app/repository/article_repo.dart';

class MockArticleRepository implements FirestoreService {
  Stream<List<Article>> getArticles() async*{
    // Return a list of mock articles for testing.
    yield [
      Article(
        author: 'Test Author 1',
        article: 'Test Article 1',
        index: 1,
        title: 'Test Title 1',
      ),
      Article(
        author: 'Test Author 2',
        article: 'Test Article 2',
        index: 2,
        title: 'Test Title 2',
      ),
    ];
  }

  Future<void> addArticle(Article article) async {
    // Mock implementation for adding an article.
    // You can perform validation or check for errors here if needed.
  }

  Future<void> updateArticle(Article article) async {
    // Mock implementation for updating an article.
    // You can perform validation or check for errors here if needed.
  }
}
