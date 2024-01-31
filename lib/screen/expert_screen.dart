import 'package:derviza_app/model/expert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ExpertProfilePage extends StatefulWidget {
  final Expert expert;

  ExpertProfilePage({Key? key, required this.expert}) : super(key: key);

  @override
  _ExpertProfilePageState createState() => _ExpertProfilePageState();
}

class _ExpertProfilePageState extends State<ExpertProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expert Profile'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.expert.imagesUrl),
            ),
            SizedBox(height: 10),
            Text(
              widget.expert.name,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF598216)),
            ),
            Text(
              widget.expert.speciality,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: 4, // Number of detail cards
                itemBuilder: (context, index) {
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: -200, end: 0),
                    duration: Duration(milliseconds: 500 + index * 300),
                    curve: Curves.easeOut,
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: child,
                      );
                    },
                    child: getDetailCard(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDetailCard(int index) {
    switch (index) {
      case 1:
        return DetailCard(title: 'Description', value: widget.expert.description);
      case 2:
        return DetailCard(title: 'Experience', value: '${widget.expert.experience} years');
      case 3:
        return DetailCard(
          title: 'Rating',
          value: '${widget.expert.rating}',
          trailing: RatingBarIndicator(
            rating: widget.expert.rating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        );
        
      default:
        return SizedBox();
    }
  }
}

class DetailCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget? trailing;

  const DetailCard({Key? key, required this.title, required this.value, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Color(0xFF598216))),
        subtitle: Text(value),
        trailing: trailing,
      ),
    );
  }
}

