import 'package:derviza_app/model/article.dart';

abstract class ArticleEvent {}

class LoadArticles extends ArticleEvent {}

class AddArticle extends ArticleEvent {
  final Article article;

  AddArticle(this.article);
}

class UpdateArticle extends ArticleEvent {
  final Article article;

  UpdateArticle(this.article);
}
