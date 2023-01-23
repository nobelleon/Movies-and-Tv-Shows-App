import 'package:movies_n_tvshows_app/models/person_tv.dart';

class TvResponsePeople {
  final List<PersonTv> personTvs;
  final String error;

  TvResponsePeople(this.personTvs, this.error);

  TvResponsePeople.fromJson(Map<String, dynamic> json)
      : personTvs = (json["results"] as List)
            .map((i) => new PersonTv.fromJson(i))
            .toList(),
        error = "";

  TvResponsePeople.withError(String errorValue)
      : personTvs = [],
        error = errorValue;
}
