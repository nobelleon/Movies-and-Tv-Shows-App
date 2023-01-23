import 'package:movies_n_tvshows_app/models/pemeran.dart';

class ResponPemeran {
  final List<Pemeran> pemeran;
  final String error;

  ResponPemeran(this.pemeran, this.error);

  ResponPemeran.fromJson(Map<String, dynamic> json)
      : pemeran =
            (json["cast"] as List).map((i) => new Pemeran.fromJson(i)).toList(),
        error = "";

  ResponPemeran.withError(String errorValue)
      : pemeran = [],
        error = errorValue;
}
