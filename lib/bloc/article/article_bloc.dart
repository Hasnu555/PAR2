import 'package:derviza_app/bloc/article/article_event.dart';
import 'package:derviza_app/bloc/article/article_state.dart';
import 'package:derviza_app/repository/article_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final FirestoreService _firestoreService;

  ArticleBloc(this._firestoreService) : super(ArticleInitial()) {
    on<LoadArticles>((event, emit) async {
      try {
        emit(ArticleLoading());
        final articles = await _firestoreService.getArticles().first;
        emit(ArticleLoaded(articles));
      } catch (e) {
        emit(ArticleError('Failed to load articles.'));
      }
    });

    on<AddArticle>((event, emit) async {
      try {
        emit(ArticleLoading());
        await _firestoreService.addArticle(event.article);
        emit(ArticleOperationSuccess('Article added successfully.'));
      } catch (e) {
        emit(ArticleError('Failed to add article.'));
      }
    });

    on<UpdateArticle>((event, emit) async {
      try {
        emit(ArticleLoading());
        await _firestoreService.updateArticle(event.article);
        emit(ArticleOperationSuccess('Article updated successfully.'));
      } catch (e) {
        emit(ArticleError('Failed to update article.'));
      }
    });
  }
}
