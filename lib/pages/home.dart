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

//route homePage

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
        Pokemon poke = Pokemon(data[i]["name"], i + 1);
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
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 31, 31, 31),
          leading: Icon(Icons.catching_pokemon_outlined),
          actions: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavPage(
                                    pokemons: favs,
                                  )))
                    },
                icon: Icon(Icons.star_outline_rounded))
          ]),
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
      ),
    );
  }

  List<Pokemon> favs = [];
  late Pokemon info;

  List<Widget> _listImgs(List<Pokemon> data) {
    List<Widget> imgs = [];
    for (var img in data) {
      imgs.add(Card(
          child: Column(
        children: [
          Text("#${img.id}"),
          Expanded(
              child: Image.network(
            img.image,
            fit: BoxFit.fill,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Text(img.getName()),
              IconButton(
                onPressed: () => {
                  !favs.contains(img) ? favs.add(img) : favs.remove(img),
                  setState(() {})
                },
                icon: Icon(!favs.contains(img)
                    ? Icons.star_outline_rounded
                    : Icons.star_rounded),
              ),
              IconButton(
                onPressed: () => {
                  setState(() {}),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Info(pokemon: img)))
                },
                icon: Icon(Icons.question_mark),
              )
            ]),
          )
        ],
      )));
    }
    return imgs;
  }

  List<Widget> getInfo(Pokemon data) {
    List<Widget> list = [];

    for (var sprite in data.sprites) {
      list.add(Expanded(
          child: Image.network(
        sprite,
        fit: BoxFit.fill,
      )));
    }

    return list;
  }

  List<Widget> getInfo2(List<Pokemon> pokemons) {
    List<Widget> list = [];

    for (var pokemon in pokemons) {
      list.add(Expanded(child: Image.network(pokemon.image, fit: BoxFit.fill)));
      list.add(Text("#${pokemon.id} ${pokemon.getName()}"));
    }

    return list;
  }
}
//route favoritos

class FavPage extends StatelessWidget {
  const FavPage({super.key, required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(179, 58, 58, 58),
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.catching_pokemon_outlined)),
      ),
      body: Column(
        children: _homePageState().getInfo2(pokemons),
      ),
    );
  }
}

//route Pokemon

class Info extends StatelessWidget {
  const Info({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(179, 58, 58, 58),
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.catching_pokemon_outlined)),
      ),
      body: Column(children: [
        Text("Pókemon: #${pokemon.id}"),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(children: [
            Expanded(
                child: Image.network(
              pokemon.image,
              fit: BoxFit.cover,
            ))
          ]),
        ),
        Text("Nombre: ${pokemon.getName()}"),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: _homePageState().getInfo(pokemon)),
        )
      ]),
    );
  }
}