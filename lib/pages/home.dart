// //menu dragoncitos
// import 'dart:convert';
// import 'dart:js_util';
// import 'package:flutter/material.dart';
// import 'package:pokedex/pages/Img.dart';
// import 'package:http/http.dart' as http;

//menu dragoncitos
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex/pages/Img.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/type/Pokemon.dart';

class homePage extends StatefulWidget {
  static const String route = "/home";
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<List<Pokemon>> pokemons;
  var url = "https://pokeapi.co/api/v2/pokemon?limit=151";

  Future<List<Pokemon>> _getPokemons() async {
    final response = await http.get(Uri.parse(url));

    List<Pokemon> pokes = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["results"];
      for (int i = 0; i < data.length; i++) {
        Pokemon poke = Pokemon(data[i]["name"], i+1);
        print(poke.toString());
        pokes.add(poke);
      }
    } else {
      throw Exception('Falló la conexión');
    }
    return pokes;
  }

  @override
  void initState() {
    super.initState();
    pokemons = _getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: FutureBuilder(
        future: pokemons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            List<Pokemon> poke = snapshot.requireData;
            return GridView.count(
              crossAxisCount: 2,
              children: _listImgs(poke),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
        // child: Container(
        //   child: Text('Contenido'),
        // )
      ),
    );
  }

  List<Widget> _listImgs(List<Pokemon> data) {
    List<Widget> imgs = [];
    for (var img in data) {
      imgs.add(Card(
          child: Column(
        children: [
          Expanded(
              child: Image.network(
            img.image,
            fit: BoxFit.fill,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Text(img.name),
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.star_outline_rounded),
              )
            ]),
          )
        ],
      )));
    }
    return imgs;
  }
}

