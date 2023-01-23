import 'package:movies_n_tvshows_app/models/aliran.dart';

// Respon Genre Film
class ResponAliran {
  final List<Aliran> alirans;
  final String error;

  ResponAliran(this.alirans, this.error);

  ResponAliran.fromJson(Map<String, dynamic> json)
      : alirans = (json["genres"] as List)
            .map((i) => new Aliran.fromJson(i))
            .toList(),
        error = "";

  ResponAliran.withError(String errorValue)
      : alirans = [],
        error = errorValue;
}
