class Pokemon {
  String name = "";
  int id = 0;
  String image = "";

  Pokemon(name, id) {
    this.name = name;
    this.id = id;
    image =
        "https://raw.githubusercontent.com/PokeAPI/sprites/f301664fbbce6ccbe09f9561287e05653379f870/sprites/pokemon/${id}.png";
  }

  String getName() {
    return name;
  }

  String getImage() {
    return image;
  }

  @override
  String toString() {
    return "Pokemon={id:${id},name:${name},image:${image}};";
  }
}