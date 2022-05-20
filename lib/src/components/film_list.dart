
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:starwarscharacter/src/model/film_model.dart';
import 'package:starwarscharacter/src/providers/api_provider.dart';

class FilmList extends StatefulWidget{
  final List<String> filmListUrl;

  const FilmList({
    super.key,
    required this.filmListUrl,
  });

  @override
  FilmListState createState () => FilmListState();
}

class FilmListState extends State<FilmList>{
  final apiProvider = ApiProvider();

  List<FilmModel> filmList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFilms();
  }

  void loadFilms () async {
    final list = await apiProvider.loadFilms(widget.filmListUrl);
    if (!mounted) return;

    setState(() {
      filmList = [...list];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Films", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          const Divider(height: 20, color: Colors.white),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildList(){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filmList.length,
      itemBuilder: (context, i) => _buildItem(context, filmList[i]),
    );
  }

  Widget _buildItem(context, FilmModel film) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(film.title),
        subtitle: Text("Episode ${film.episodeId}"),
        leading: Image(
          image: AssetImage( 'assets/img/films/${film.id}.jpeg'),
        ),
      ),
    );
  }
}