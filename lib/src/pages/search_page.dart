
import 'package:flutter/material.dart';
import 'package:starwarscharacter/src/components/character_list.dart';
import 'package:starwarscharacter/src/model/character_model.dart';
import 'package:starwarscharacter/src/providers/api_provider.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({
    super.key,
  });

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final apiProvider = ApiProvider();

  final _controller = TextEditingController();

  List<CharacterModel> characterList = [];
  bool isLoading = false;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _inputSearch(),
      body: SingleChildScrollView(
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
      ),
    );
  }

  void _searchOperation(String searchText) async {
    if (searchText.isEmpty){
      setState(() { characterList = []; });
      return;
    }
    
    setState(() { isLoading = true; });
    final characters = await apiProvider.searchCharacters(search: searchText);
    setState(() {
      characterList = characters;
      isLoading = false;
    });
  }

  PreferredSizeWidget _inputSearch () {
    return AppBar(
      title: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white),
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.white),
        ),
        onChanged: _searchOperation,
      ),
    );
  }
}