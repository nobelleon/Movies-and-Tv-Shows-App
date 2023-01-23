import 'package:movies_n_tvshows_app/gudang/gudang_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_tv.dart';
import 'package:rxdart/rxdart.dart';

class TvOnTheAirBloc {
  final GudangTv _gudangTv = GudangTv();
  final BehaviorSubject<ResponTv> _subject = BehaviorSubject<ResponTv>();

  BehaviorSubject<ResponTv> get subject => _subject;

  getTvs() async {
    ResponTv response = await _gudangTv.getTvOnTheAir();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }
}

final tvOnTheAirBloc = TvOnTheAirBloc();
