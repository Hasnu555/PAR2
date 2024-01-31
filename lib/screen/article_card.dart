import 'package:flutter/material.dart';
import 'package:derviza_app/model/article.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;

  ArticleListItem({required this.article});

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage('assets/images/article.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(),
            ),
          ),
          ListTile(
            title: Text(
              article.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(0xFF416422), // Text color
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 8.0),
                Text(
                  article.article,
                  style: TextStyle(
                    fontFamily: 'Noto Sans',
                    fontStyle: FontStyle.italic,
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Author: ${article.author}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF416422),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
