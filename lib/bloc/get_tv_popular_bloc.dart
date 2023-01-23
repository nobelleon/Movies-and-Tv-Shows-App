import 'package:flutter/cupertino.dart';
import 'package:movies_n_tvshows_app/gudang/gudang_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_tv.dart';
import 'package:rxdart/subjects.dart';

class TvsPopularBloc {
  final GudangTv _gudangTv = GudangTv();
  final BehaviorSubject<ResponTv> _subject = BehaviorSubject<ResponTv>();

  getTvsPopular() async {
    ResponTv response = await _gudangTv.getTvsPopular();
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

  BehaviorSubject<ResponTv> get subject => _subject;
}

final tvsPopularBloc = TvsPopularBloc();
