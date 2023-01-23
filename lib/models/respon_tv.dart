import 'package:movies_n_tvshows_app/models/tv.dart';

class ResponTv {
  final List<Tv> tvs;
  final String error;

  ResponTv(this.tvs, this.error);

  ResponTv.fromJson(Map<String, dynamic> json)
      : tvs = (json["results"] as List).map((i) => new Tv.fromJson(i)).toList(),
        error = "";

  ResponTv.withError(String errorValue)
      : tvs = [],
        error = errorValue;
}
