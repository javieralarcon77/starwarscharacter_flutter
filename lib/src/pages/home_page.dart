import 'package:flutter/material.dart';

import 'package:starwarscharacter/src/components/character_list.dart';
import 'package:starwarscharacter/src/model/character_model.dart';
import 'package:starwarscharacter/src/pages/search_page.dart';
import 'package:starwarscharacter/src/providers/api_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override 
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
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

  void goToSearch () {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const SearchPage();
        },
      )
    );
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars Character"),
        actions: [
          IconButton(
            onPressed: goToSearch, 
            icon: const Icon(Icons.search)
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          margin: const EdgeInsets.only(bottom: 50.0),
          child: Column(
            children: [
              CharacterList(
                characterList: characterList,
              ),
              isLoading ?
                const CircularProgressIndicator() :
                Container()
            ],
          ),
        ),
      )
    );
  }
}