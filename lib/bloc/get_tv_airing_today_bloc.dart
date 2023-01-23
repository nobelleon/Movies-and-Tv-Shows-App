import 'package:movies_n_tvshows_app/gudang/gudang_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_aliran_tv.dart';
import 'package:rxdart/subjects.dart';

import '../models/respon_tv.dart';

class TvAiringTodayListBloc {
  final GudangTv _gudangTv = GudangTv();
  final BehaviorSubject<ResponTv> _subject = BehaviorSubject<ResponTv>();

  getTvAiringToday() async {
    ResponTv response = await _gudangTv.getTvAiringToday();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ResponTv> get subject => _subject;
}

final tvAiringTodayBloc = TvAiringTodayListBloc();
