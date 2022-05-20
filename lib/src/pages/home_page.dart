import 'package:flutter/material.dart';
import 'package:starwarscharacter/src/components/character_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars Character"),
      ),
      body: const CharacterList()
    );
  }
}