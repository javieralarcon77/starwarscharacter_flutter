
class CharacterModel {
  String id;
  String name;
  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  String homeworld;
  List<dynamic> films;
  List<dynamic> species;
  List<dynamic> vehicles;
  List<dynamic> starships;
  String created;
  String edited;
  String url;

  CharacterModel({
    required this.id,
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
  });


  factory CharacterModel.formJson(Map<String, dynamic> json) {
    final parts = json["url"].toString().split("/");
    String id = parts[parts.length - 2];
    
    return CharacterModel(
      id:         id,
      name:       json["name"],
      height:     json["height"],
      mass:       json["mass"],
      hairColor:  json["hair_color"],
      skinColor:  json["skin_color"],
      eyeColor:   json["eye_color"],
      birthYear:  json["birth_year"],
      gender:     json["gender"],
      homeworld:  json["homeworld"],
      films:      json["films"],
      species:    json["species"],
      vehicles:   json["vehicles"],
      starships:  json["starships"],
      created:    json["created"],
      edited:     json["edited"],
      url:        json["url"]
    );
  }
}
