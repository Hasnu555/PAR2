import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derviza_app/model/article.dart';


class FirestoreService {
  final CollectionReference _articlesCollection =
      FirebaseFirestore.instance.collection('articles');

  Stream<List<Article>> getArticles() {
    return _articlesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Article(
          author: data['author'],
          article: data['article'],
          index: data['index'],
          title: data['title'],
        );
      }).toList();
    });
  }

  Future<void> addArticle(Article article) {
    return _articlesCollection.add({
      'author': article.author,
      'article': article.article,
      'index': article.index,
      'title': article.title,
    });
  }

  Future<void> updateArticle(Article article) {
    return _articlesCollection.doc(article.index.toString()).update({
      'author': article.author,
      'article': article.article,
      'index': article.index,
      'title': article.title,
    });
  }
}
