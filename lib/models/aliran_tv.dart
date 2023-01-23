class AliranTv {
  final int id;
  final String name;

  AliranTv(this.id, this.name);

  AliranTv.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
