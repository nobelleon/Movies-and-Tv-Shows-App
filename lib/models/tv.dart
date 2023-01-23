class Tv {
  final int id;
  final double popularity;
  final String name;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;

  Tv(
    this.id,
    this.popularity,
    this.name,
    this.backPoster,
    this.poster,
    this.overview,
    this.rating,
  );

  // mengambil data dari Json
  Tv.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble();
}
