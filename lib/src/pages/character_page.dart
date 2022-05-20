
import 'package:flutter/material.dart';
import 'package:starwarscharacter/src/components/character_line.dart';
import 'package:starwarscharacter/src/components/character_url.dart';
import 'package:starwarscharacter/src/model/character_model.dart';

class CharacterPageArguments {
  final CharacterModel character;
  CharacterPageArguments(this.character);
}


class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});
  
  @override
  Widget build (BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CharacterPageArguments;
    final character = args.character;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _characterImage(context, character),
            _characterData(character),
          ],
        ),
      )
    );
  }

  Widget _characterImage (BuildContext context, CharacterModel character) {
    final heigth = MediaQuery.of(context).size.height;
    return Image(
      image: AssetImage( 'assets/img/characters/${character.id}.jpeg'),
      height: heigth / 2,
      width: double.infinity,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }

  Widget _characterData (CharacterModel character) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          CharacterLine(title: "Birth Year", text: character.birthYear),
          CharacterLine(title: "Height", text: character.height),
          CharacterLine(title: "Mass", text: character.mass),
          CharacterLine(title: "Gender", text: character.gender),
          CharacterLine(title: "Hair Color", text: character.hairColor),
          CharacterLine(title: "Skin Color", text: character.skinColor),
          character.species.isNotEmpty ? 
            CharacterUrl(title: "Species", url: character.species[0]) :
            const CharacterLine(title: "Species", text:"Human"),
          CharacterUrl(title: "Homeworld", url: character.homeworld),
        ],
      )
    );
  }
}