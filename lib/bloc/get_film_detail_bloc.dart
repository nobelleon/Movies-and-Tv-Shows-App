import 'package:movies_n_tvshows_app/gudang/gudang_film.dart';
import 'package:movies_n_tvshows_app/models/respon_detail_film.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class FilmDetailBloc {
  final GudangFilm _gudangFilm = GudangFilm();
  final BehaviorSubject<ResponDetailFilm> _subject =
      BehaviorSubject<ResponDetailFilm>();

  getFilmDetail(int id) async {
    ResponDetailFilm response = await _gudangFilm.getFilmDetail(id);
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

  BehaviorSubject<ResponDetailFilm> get subject => _subject;
}

final movieDetailBloc = FilmDetailBloc();
