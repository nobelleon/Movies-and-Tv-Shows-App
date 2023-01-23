import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/bloc/get_now_playing_bloc.dart';
import 'package:movies_n_tvshows_app/models/film.dart';
import 'package:movies_n_tvshows_app/models/respon_film.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    nowPlayingFilmsBloc..getFilms();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResponFilm>(
        stream: nowPlayingFilmsBloc.subject.stream,
        builder: (context, AsyncSnapshot<ResponFilm> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _bangunwidgetError(snapshot.data.error);
            }
            return _bangunWidgetNowPlaying(snapshot.data);
          } else if (snapshot.hasError) {
            return _bangunwidgetError(snapshot.error);
          } else {
            return _bangunWidgetLoading();
          }
        });
  }

  // bangun Widget Loading
  Widget _bangunWidgetLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

  // bangun Widget Error
  Widget _bangunwidgetError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Terjadi kesalahan: $error"),
        ],
      ),
    );
  }

  // bangun Widget Now Playing
  Widget _bangunWidgetNowPlaying(ResponFilm data) {
    List<Film> films = data.films;
    if (films.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tidak Ada Film Lagi..",
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      );
    } else
      return Container(
        height: 220.0,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          length: films.take(7).length, // 7 film
          indicatorSpace: 8.0,
          padding: EdgeInsets.all(5.0),
          indicatorColor: Colors.purple,
          indicatorSelectorColor: Colors.amber,
          shape: IndicatorShape.circle(size: 5.0),
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: films.take(7).length, // 7 film
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  // Image back Poster
                  Hero(
                    tag: films[index].id,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/original/" +
                                  films[index].backPoster),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.0,
                            0.9
                          ],
                          colors: [
                            Style.Warna.mainColor.withOpacity(1.0),
                            Style.Warna.mainColor.withOpacity(0.0)
                          ]),
                    ),
                  ),
                  // Tombol Play
                  // Positioned(
                  //   bottom: 0.0,
                  //   top: 0.0,
                  //   left: 0.0,
                  //   right: 0.0,
                  //   child: Icon(
                  //     FontAwesomeIcons.playCircle,
                  //     color: Colors.cyan[600],
                  //     size: 41.0,
                  //   ),
                  // ),
                  Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            films[index].title,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
  }
}
