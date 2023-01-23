import 'package:movies_n_tvshows_app/gudang/gudang_film.dart';
import 'package:movies_n_tvshows_app/models/respon_film.dart';
import 'package:rxdart/rxdart.dart';

class FilmsListBloc {
  final GudangFilm _gudangFilm = GudangFilm();
  final BehaviorSubject<ResponFilm> _subject = BehaviorSubject<ResponFilm>();

  getFilms() async {
    ResponFilm response = await _gudangFilm.getFilms();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ResponFilm> get subject => _subject;
}

final filmsListBloc = FilmsListBloc();
