//menu dragoncitos
import 'dart:convert';

import 'package:flutter/material.dart';
import 'Img.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  static const String route = "/home";
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<List<String>> _listadoImg;

  Future <List<Img>> _getGifts () async{
    final response= await http.get("https://raw.githubusercontent.com/PokeAPI/sprites/f301664fbbce6ccbe09f9561287e05653379f870/sprites/pokemon/${ID}.png");
    
    List<Img> imgs=[];
    
    if(response.statusCode==200){
      String body= utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print(jsonData["data"])
    }else{
      throw Exception('Falló la conexión');
    }

  }
  @override
  void initState() {
    super.initState();
    _getGifts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: Center(
          child: Container(
        child: Text('Contenido'),
      )),
    );
  }
}


