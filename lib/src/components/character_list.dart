
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

import 'package:starwarscharacter/src/model/character_model.dart';
import 'package:starwarscharacter/src/providers/api_provider.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({ super.key });

  @override
  CharacterListState createState() => CharacterListState();
}

class CharacterListState extends State<CharacterList>{
  final apiProvider = ApiProvider();
  final scrollController = ScrollController();

  List<CharacterModel> characterList = [];
  int pageCurrent = 1;
  bool isMore = true;
  bool isLoading = true;

  loadCharacters() async {
    final characters = await apiProvider.loadCharacters(page: pageCurrent);
    setState(() {
      isLoading = false;
      characterList = [...characters];
    });
  }

  nextCharacters() async {
    final characters = await apiProvider.loadCharacters(page: pageCurrent + 1);
    setState(() {
      characterList.addAll(characters);
      pageCurrent = pageCurrent + 1;    
      isMore = characters.isNotEmpty;
      isLoading = false;
    });
  }
  
  @override
  void initState(){
    super.initState();
    loadCharacters();    
    scrollController.addListener(listenScroll);
  }

  void listenScroll(){
    if (scrollController.position.atEdge){
      final isTop = scrollController.position.pixels == 0;
      if (!isTop && isMore) {
        setState(() { isLoading = true; });
        nextCharacters();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        margin: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          children: [
            _buildList(),
            isLoading ?
              const CircularProgressIndicator() :
              Container()
          ],
        ),
      ),
    );
  }

  Widget _buildList () {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: characterList.length,
      itemBuilder: (context, i) => _buildItem(context, characterList[i]),
    );
  }

  Widget _buildItem (BuildContext context, CharacterModel character) {
    return Card(
      key: Key(character.id),
      child: Column(
        children: [
          ListTile(
            title: Text(utf8.decode(character.name.runes.toList())),
            subtitle: Text(character.gender),
          )
        ],
      ),
    );
  }
}