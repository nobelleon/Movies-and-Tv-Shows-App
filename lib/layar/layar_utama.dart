import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:movies_n_tvshows_app/models/person.dart';

import 'package:movies_n_tvshows_app/widgets/film_terbaik.dart';
import 'package:movies_n_tvshows_app/widgets/layar_genre.dart';
import 'package:movies_n_tvshows_app/widgets/now_playing.dart';
import 'package:movies_n_tvshows_app/widgets/persons.dart';
import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;

import '../widgets/layar_upcoming.dart';
import '../widgets/persons_tv_shows.dart';
import '../widgets/tv_airing_today.dart';
import '../widgets/tv_on_the_air.dart';
import '../widgets/tv_shows_popular.dart';
import '../widgets/tv_shows_terbaik.dart';

class LayarUtama extends StatefulWidget {
  @override
  _LayarUtamaState createState() => _LayarUtamaState();
}

class _LayarUtamaState extends State<LayarUtama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Warna.fifthColor, //mainColor
      appBar: AppBar(
        backgroundColor: Style.Warna.fifthColor,
        centerTitle: true,
        leading: const Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: const Text("Movies & Tv Shows"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(EvaIcons.moreVertical, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(), // Movies
          LayarGenre(), // Movies
          const LayarUpcoming(), // Movies
          Persons(), // Movies
          FilmTerbaik(), // Movies
          const TvOnTheAir(), // Tv Shows
          const TvAiringToday(), // Tv Shows
          const TvShowsPopular(), // Tv Shows
          const PersonsTvShows(), // Tv Shows
          const TvShowsTerbaik(), // Tv Shows
        ],
      ),
    );
  }
}
