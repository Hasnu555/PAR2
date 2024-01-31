import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 18),
    
        decoration: BoxDecoration(
          color: Color(0xFFFAD382),
          borderRadius: BorderRadius.circular(8),
          ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16),
          ),
          ),
      ),
    );
  }
}