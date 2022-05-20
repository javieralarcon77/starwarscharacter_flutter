// Generated by https://quicktype.io

class FilmModel {
  String id;
  String title;
  int episodeId;
  String openingCrawl;
  String director;
  String producer;
  String releaseDate;
  List<String> characters;
  List<String> planets;
  List<String> starships;
  List<String> vehicles;
  List<String> species;
  String created;
  String edited;
  String url;

  FilmModel({
    required this.id,
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.characters,
    required this.planets,
    required this.starships,
    required this.vehicles,
    required this.species,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory FilmModel.formJson(Map<String, dynamic> json){
    final parts = json["url"].toString().split("/");
    String id = parts[parts.length - 2];

    return FilmModel(
      id:           id,
      title:        json["title"],
      episodeId:    json["episode_id"],
      openingCrawl: json["opening_crawl"],
      director:     json["director"],
      producer:     json["producer"],
      releaseDate:  json["release_date"],
      characters:   List<String>.from(json["characters"]),
      planets:      List<String>.from(json["planets"]),
      starships:    List<String>.from(json["starships"]),
      vehicles:     List<String>.from(json["vehicles"]),
      species:      List<String>.from(json["species"]),
      created:      json["created"],
      edited:       json["edited"],
      url:          json["url"],
    );
  }
}
