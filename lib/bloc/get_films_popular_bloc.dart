import 'package:movies_n_tvshows_app/gudang/gudang_film.dart';
import 'package:movies_n_tvshows_app/models/respon_film.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/subjects.dart';

class FilmsPopularBloc {
  final GudangFilm _gudangFilm = GudangFilm();
  final BehaviorSubject<ResponFilm> _subject = BehaviorSubject<ResponFilm>();

  getFilmsPopular(int id) async {
    ResponFilm response = await _gudangFilm.getFilmsPopular(id);
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ResponFilm> get subject => _subject;
}

final filmsPopularBloc = FilmsPopularBloc();
