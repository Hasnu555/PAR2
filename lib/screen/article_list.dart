import 'package:derviza_app/bloc/article/article_event.dart';
import 'package:derviza_app/bloc/article/article_state.dart';
import 'package:derviza_app/bloc/article/article_bloc.dart';
import 'package:derviza_app/model/article.dart';
import 'package:derviza_app/screen/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Color primaryColor = Color.fromARGB(255, 211, 238, 167);
  final Color secondaryColor = Color(0xFFE8f4F2);

  @override
  void initState() {
    BlocProvider.of<ArticleBloc>(context).add(LoadArticles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ArticleBloc _articleBloc = BlocProvider.of<ArticleBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Agriculture Articles'),
      ),
      backgroundColor: Color.fromARGB(255, 236, 241, 228),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ArticleLoaded) {
            final articles = state.articles;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                // ...

                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/article.jpg'), // Replace with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                      ),
                      //                     ListView.builder(
                      // itemCount: articles.length,
                      // itemBuilder: (context, index) {
                      //   final article = articles[index];
                      // return
                      ArticleListItem(article: article),
//   },
// ),

                      // ListTile(
                      //   title: Text(
                      //     article.title,
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 18.0,
                      //       color: Color(0xFF416422), // Text color
                      //     ),
                      //   ),
                      //   subtitle: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: [
                      //       SizedBox(height: 8.0),
                      //       Text(
                      //         article.article,
                      //         style: TextStyle(
                      //           fontFamily: 'Noto Sans',
                      //           fontStyle: FontStyle.italic,
                      //           fontSize: 14.0,
                      //           color:
                      //               Colors.black,
                      //         ),
                      //       ),
                      //       SizedBox(height: 8.0),
                      //       Text(
                      //         'Author: ${article.author}',
                      //         style: TextStyle(
                      //             fontSize: 14.0,
                      //             color: Color(0xFF416422),
                      //             fontWeight: FontWeight.bold
                      //             ),
                      //       ),
                      //     ],
                      //   ),
                      //   onTap: () {

                      //   },
                      // ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ArticleOperationSuccess) {
            _articleBloc.add(LoadArticles());
            return Container();
          } else if (state is ArticleError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddArticleDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF819a20),
      ),
    );
  }

  void _showAddArticleDialog(BuildContext context) {
    final _titleController = TextEditingController();
    final _authorController = TextEditingController();
    final _articleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Article'),
          backgroundColor: primaryColor,
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Article title',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: _authorController,
                decoration: InputDecoration(
                  hintText: 'Author',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: _articleController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Article content',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF598216),
              ),
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                final article = Article(
                  author: _authorController.text,
                  article: _articleController.text,
                  index: DateTime.now().millisecondsSinceEpoch,
                  title: _titleController.text,
                );
                BlocProvider.of<ArticleBloc>(context).add(AddArticle(article));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF598216),
              ),
            ),
          ],
        );
      },
    );
  }
}
