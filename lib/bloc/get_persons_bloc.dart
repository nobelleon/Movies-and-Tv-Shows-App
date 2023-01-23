import 'package:movies_n_tvshows_app/gudang/gudang_film.dart';
import 'package:movies_n_tvshows_app/models/tanggapan_orang.dart';
import 'package:rxdart/rxdart.dart';

class PersonsListBloc {
  final GudangFilm _gudangFilm = GudangFilm();
  final BehaviorSubject<TanggapanOrang> _subject =
      BehaviorSubject<TanggapanOrang>();

  getPersons() async {
    TanggapanOrang response = await _gudangFilm.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<TanggapanOrang> get subject => _subject;
}

final personsBloc = PersonsListBloc();
