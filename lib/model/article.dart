import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Article extends Equatable {
  final String author;
  final String article;
  final String title;
  final int index;

  Article({
    required this.author,
    required this.article,
    required this.title,
    required this.index,
  });

  @override
  List<Object?> get props => [author, article, title, index];

  static List<Article> _articlesData = [];

  static Future<List<Article>>? fetchDataFromFirestore() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('articles').get();

    _articlesData = snapshot.docs
        .map((doc) {
          final data = doc.data();

          if (data['author'] != null &&
              data['article'] != null &&
              data['index'] != null &&
              data['title'] != null) {
            return Article(
              author: data['author'],
              article: data['article'],
              index: data['index'],
              title: data['title'],
            );
          } else {
            return null;
          }
        })
        .whereType<Article>() // Filter out null values
        .toList();

    return _articlesData;
  }

  static Future<List<Article>> getFirebaseData() async {
    if (_articlesData.isEmpty) {
      await fetchDataFromFirestore();
    }
    return _articlesData;
  }
}
