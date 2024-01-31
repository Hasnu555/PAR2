import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AdWidget extends StatelessWidget {
  final String imageUrl;
  final String adLink;

  const AdWidget({required this.imageUrl, required this.adLink});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchURL(adLink);
      },
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
