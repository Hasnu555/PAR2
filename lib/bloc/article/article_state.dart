import 'package:derviza_app/model/article.dart';
import 'package:equatable/equatable.dart';

abstract class ArticleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;

  ArticleLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class ArticleOperationSuccess extends ArticleState {
  final String message;

  ArticleOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ArticleError extends ArticleState {
  final String errorMessage;

  ArticleError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
