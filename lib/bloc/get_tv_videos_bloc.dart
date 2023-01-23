import 'package:flutter/cupertino.dart';
import 'package:movies_n_tvshows_app/gudang/gudang_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_video_tv.dart';
import 'package:rxdart/rxdart.dart';

class TvVideosBloc {
  final GudangTv _gudangTv = GudangTv();
  final BehaviorSubject<ResponVideoTv> _subject =
      BehaviorSubject<ResponVideoTv>();

  getTvVideos(int id) async {
    ResponVideoTv response = await _gudangTv.getTvVideos(id);
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

  BehaviorSubject<ResponVideoTv> get subject => _subject;
}

final tvVideosBloc = TvVideosBloc();
