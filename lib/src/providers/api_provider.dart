import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:starwarscharacter/src/model/character_model.dart';

class ApiProvider {
  final String _url = 'https://swapi.dev/api';

  Future <List<CharacterModel>> loadCharacters ({ int page = 1 }) async {

    final url = '$_url/people/?page=$page';
    final resp = await http.get(Uri.parse(url));
    
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<CharacterModel> characters = [];

    if (decodedData["results"] == null) return characters;

    decodedData["results"].forEach((item){
      final character = CharacterModel.formJson(item);
      characters.add(character);
    });
    return characters;
  }
}
