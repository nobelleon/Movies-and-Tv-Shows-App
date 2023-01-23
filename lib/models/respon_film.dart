import 'package:movies_n_tvshows_app/models/film.dart';

class ResponFilm {
  final List<Film> films;
  final String error;

  ResponFilm(this.films, this.error);

  ResponFilm.fromJson(Map<String, dynamic> json)
      : films =
            (json["results"] as List).map((i) => new Film.fromJson(i)).toList(),
        error = "";

  ResponFilm.withError(String errorValue)
      : films = [],
        error = errorValue;
}
