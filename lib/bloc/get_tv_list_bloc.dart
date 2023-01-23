import 'package:movies_n_tvshows_app/gudang/gudang_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_tv.dart';
import 'package:rxdart/rxdart.dart';

// Top Rated

class TvListBloc {
  final GudangTv _gudangTv = GudangTv();
  final BehaviorSubject<ResponTv> _subject = BehaviorSubject<ResponTv>();

  // Top Rated
  getTvs() async {
    ResponTv response = await _gudangTv.getTvs();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ResponTv> get subject => _subject;
}

final tvsListBloc = TvListBloc();
