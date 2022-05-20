
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

import 'package:starwarscharacter/src/model/character_model.dart';
import 'package:starwarscharacter/src/pages/character_page.dart';

class CharacterList extends StatelessWidget {
  
  final List<CharacterModel> characterList;

  const CharacterList({ 
    super.key, 
    required this.characterList 
  });  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: characterList.length,
      itemBuilder: (context, i) => _buildItem(context, characterList[i]),
    );
  }

  void goToCharacter(BuildContext context, CharacterModel character){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const CharacterPage();
        },
        settings: RouteSettings(
          arguments: CharacterPageArguments(character)
        )
      )
    );
  }

  Widget _buildItem (BuildContext context, CharacterModel character) {
    return ListTile(
      key: Key(character.id),
      onTap: () => goToCharacter(context, character),
      title: Text(utf8.decode(character.name.runes.toList())),
      subtitle: Text(character.gender),
      leading: CircleAvatar(
        backgroundImage: AssetImage( 'assets/img/characters/${character.id}.jpeg'),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      enableFeedback: true,
    );
  }
}