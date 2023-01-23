import 'package:movies_n_tvshows_app/models/aliran.dart';
import 'package:movies_n_tvshows_app/models/perusahaan.dart';

class DetailFilm {
  final int id;
  final bool adult;
  final int budget;
  final List<Aliran> genres;
  final List<Perusahaan> companies;
  final String releaseDate;
  final int runtime;

  DetailFilm(
    this.id,
    this.adult,
    this.budget,
    this.genres,
    this.companies,
    this.releaseDate,
    this.runtime,
  );

  DetailFilm.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        adult = json["adult"],
        budget = json["budget"],
        genres = (json["genres"] as List) // genres
            .map((i) => new Aliran.fromJson(i))
            .toList(),
        companies = (json["production_companies"] as List)
            .map((i) => new Perusahaan.fromJson(i))
            .toList(),
        releaseDate = json["release_date"],
        runtime = json["runtime"];
}
