class Pokemon {
  String name = "";
  int id = 0;
  String image = "";
  List<String> sprites = [];

  Pokemon(name, id) {
    this.name = name;
    this.id = id;
    image =
        "https://raw.githubusercontent.com/PokeAPI/sprites/f301664fbbce6ccbe09f9561287e05653379f870/sprites/pokemon/${id}.png";
    sprites.addAll([
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${id}.png",
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/${id}.png",
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${id}.png",
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/${id}.png"
    ]);
  }

  String getName() {
    return "${name[0].toUpperCase()}${name.substring(1)}";
  }

  String getImage() {
    return image;
  }

  @override
  String toString() {
    return "Pokemon={id:${id},name:${name},image:${image}};";
  }
}