import 'package:movies_n_tvshows_app/gudang/gudang_film.dart';
import 'package:movies_n_tvshows_app/models/respon_video.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class FilmVideosBloc {
  final GudangFilm _gudangFilm = GudangFilm();
  final BehaviorSubject<ResponVideo> _subject = BehaviorSubject<ResponVideo>();

  getFilmVideos(int id) async {
    ResponVideo response = await _gudangFilm.getFilmVideos(id);
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

  BehaviorSubject<ResponVideo> get subject => _subject;
}

final filmVideosBloc = FilmVideosBloc();
