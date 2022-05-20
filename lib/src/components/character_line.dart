
import 'package:flutter/material.dart';

class CharacterLine extends StatelessWidget {
  final String title;
  final String text;

  const CharacterLine({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build (BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [ 
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), 
          const Spacer(flex: 1),
          Text(text, style: const TextStyle(fontSize: 16))
        ]
      ),
    );
  }
}