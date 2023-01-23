import 'package:movies_n_tvshows_app/models/person.dart';

// Film Response People

class TanggapanOrang {
  final List<Person> persons;
  final String error;

  TanggapanOrang(this.persons, this.error);

  TanggapanOrang.fromJson(Map<String, dynamic> json)
      : persons = (json["results"] as List)
            .map((i) => new Person.fromJson(i))
            .toList(),
        error = "";

  TanggapanOrang.withError(String errorValue)
      : persons = [],
        error = errorValue;
}
