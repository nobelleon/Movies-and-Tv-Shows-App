import 'package:movies_n_tvshows_app/gudang/gudang_film.dart';
import 'package:movies_n_tvshows_app/models/respon_film.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class SimilarFilmsBloc {
  final GudangFilm _gudangFilm = GudangFilm();
  final BehaviorSubject<ResponFilm> _subject = BehaviorSubject<ResponFilm>();

  getSimilarFilms(int id) async {
    ResponFilm response = await _gudangFilm.getSimilarFilms(id);
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

final similarFilmsBloc = SimilarFilmsBloc();
