class Pemeran {
  final int id;
  final String character;
  final String name;
  final String img;

  Pemeran(
    this.id,
    this.character,
    this.name,
    this.img,
  );

  Pemeran.fromJson(Map<String, dynamic> json)
      : id = json["cast_id"],
        character = json["character"],
        name = json["name"],
        img = json["profile_path"];
}
