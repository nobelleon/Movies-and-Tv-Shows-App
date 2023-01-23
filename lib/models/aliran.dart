// Genre Film

class Aliran {
  final int id;
  final String name;

  Aliran(this.id, this.name);

  Aliran.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
