import 'package:movies_n_tvshows_app/gudang/gudang_tv.dart';
import 'package:rxdart/rxdart.dart';

import '../models/tv_response_people.dart';

class PersonsTvShowsListBloc {
  final GudangTv _gudangTv = GudangTv();
  final BehaviorSubject<TvResponsePeople> _subject =
      BehaviorSubject<TvResponsePeople>();

  getPersonsTvShow() async {
    TvResponsePeople response = await _gudangTv.getPersonsTvShow();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<TvResponsePeople> get subject => _subject;
}

final personsTvShowsBloc = PersonsTvShowsListBloc();
