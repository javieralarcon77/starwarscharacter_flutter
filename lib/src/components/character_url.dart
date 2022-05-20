
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import 'package:starwarscharacter/src/components/character_line.dart';
import 'package:starwarscharacter/src/providers/api_provider.dart';

class CharacterUrl extends StatefulWidget {
  final String title;
  final String url;
  
  const CharacterUrl({
    super.key,
    required this.title,
    required this.url,
  });

  @override 
  CharacterUrlState createState() => CharacterUrlState();
}

class CharacterUrlState extends State<CharacterUrl> {
  final apiProvider = ApiProvider();
  String texto = "";
  
  @override 
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final text = await apiProvider.loadPlanet(url: widget.url);

    if (!mounted) return;
    setState(() {
      texto = text;
    });
  }

  @override
  Widget build(BuildContext context){
    return 
      texto.isEmpty ? 
        const SkeletonLine() : 
        CharacterLine(title: widget.title, text: texto);
  }
}