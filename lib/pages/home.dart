//menu dragoncitos
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex/pages/Img.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  static const String route = "/home";
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<List<String>> _listadoImg;

  Future<List<String>> _getImgs() async {
    final response = await http.get(
        "https://raw.githubusercontent.com/PokeAPI/sprites/f301664fbbce6ccbe09f9561287e05653379f870/sprites/pokemon/${item}.png");

    List<Img> imgs = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData["data"]) {
        imgs.add(Img(item["title"], item["id"]));
      }
      return imgs;
      // return await imgs();
      // print(jsonData["data"]);
    } else {
      throw Exception('Falló la conexión');
    }
    // return _getImgs();
  }

  @override
  void initState() {
    super.initState();
    _listadoImg = _getImgs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: FutureBuilder(
        future: _listadoImg,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return GridView.count(
              crossAxisCount: 2,
              children: _listImgs (snapshot.data),
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

  List<Widget> _listImgs(List<String> data) {
    List<Widget> imgs = [];
    for (var img in data) {
      imgs.add(Card(
          child: Column(
        children: [
          Expanded(child: Image.network(img.url, fit: BoxFit.fill,)),
          
        ],
      )));
    }
    return imgs;
  }
}
