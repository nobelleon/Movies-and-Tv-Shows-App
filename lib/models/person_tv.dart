class PersonTv {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;

  PersonTv(
    this.id,
    this.popularity,
    this.name,
    this.profileImg,
    this.known,
  );

  // mengambil data dari Json
  PersonTv.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        profileImg = json["profile_path"],
        known = json["known_for_department"];
}
