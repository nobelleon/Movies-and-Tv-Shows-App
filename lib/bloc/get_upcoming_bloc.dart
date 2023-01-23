import 'package:movies_n_tvshows_app/gudang/gudang_film.dart';
import 'package:movies_n_tvshows_app/models/respon_aliran.dart';
import 'package:rxdart/subjects.dart';

class UpcomingListBloc {
  final GudangFilm _gudangFilm = GudangFilm();
  final BehaviorSubject<ResponAliran> _subject =
      BehaviorSubject<ResponAliran>();

  getGenres() async {
    ResponAliran response = await _gudangFilm.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ResponAliran> get subject => _subject;
}

final upcomingBloc = UpcomingListBloc();
