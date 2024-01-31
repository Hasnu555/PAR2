import 'package:bloc_test/bloc_test.dart';
import 'package:derviza_app/bloc/article/article_bloc.dart';
import 'package:derviza_app/bloc/article/article_event.dart';
import 'package:derviza_app/bloc/article/article_state.dart';
import 'package:derviza_app/model/article.dart';
import 'package:flutter_test/flutter_test.dart';

import 'articlemockrepo.dart';

void main() {
  group('ArticleBloc', () {
    late ArticleBloc articleBloc;

    setUp(() {
      articleBloc = ArticleBloc(MockArticleRepository()); // Use the mock repository here.
    });

    tearDown(() {
      articleBloc.close();
    });

    blocTest<ArticleBloc, ArticleState>(
      'emits [ArticleLoading, ArticleLoaded] when LoadArticles event is added',
      build: () => articleBloc,
      act: (bloc) => bloc.add(LoadArticles()),
      expect: () => [
        ArticleLoading(),
        ArticleLoaded([
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
        ]),
      ],
    );

    blocTest<ArticleBloc, ArticleState>(
      'emits [ArticleLoading, ArticleOperationSuccess] when AddArticle event is added',
      build: () => articleBloc,
      act: (bloc) => bloc.add(AddArticle(Article(
        author: 'Test Author 3',
        article: 'Test Article 3',
        index: 3,
        title: 'Test Title 3',
      ))),
      expect: () => [
        ArticleLoading(),
        ArticleOperationSuccess('Article added successfully.'),
      ],
    );

    // Add more tests for other events and states as needed.
  });
}
