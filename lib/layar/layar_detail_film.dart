import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:movies_n_tvshows_app/bloc/get_film_videos_bloc.dart';
import 'package:movies_n_tvshows_app/layar/video_player.dart';
import 'package:movies_n_tvshows_app/models/film.dart';
import 'package:movies_n_tvshows_app/models/respon_video.dart';
import 'package:movies_n_tvshows_app/models/video.dart';
import 'package:movies_n_tvshows_app/widgets/aktor.dart';
import 'package:movies_n_tvshows_app/widgets/info_film.dart';
import 'package:movies_n_tvshows_app/widgets/similar_films.dart';
import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LayarDetailFilm extends StatefulWidget {
  final Film film;

  const LayarDetailFilm({Key key, this.film}) : super(key: key);

  @override
  _LayarDetailFilmState createState() => _LayarDetailFilmState(film);
}

class _LayarDetailFilmState extends State<LayarDetailFilm> {
  final Film film;

  _LayarDetailFilmState(this.film);

  @override
  void initState() {
    super.initState();
    filmVideosBloc..getFilmVideos(film.id);
  }

  @override
  void dispose() {
    super.dispose();
    filmVideosBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Warna.fifthColor, // mainColor
      body: Builder(
        builder: (context) {
          return SliverFab(
            floatingPosition: FloatingPosition(right: 20),
            floatingWidget: StreamBuilder<ResponVideo>(
              stream: filmVideosBloc.subject.stream,
              builder: (context, AsyncSnapshot<ResponVideo> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return _bangunWidgetError(snapshot.data.error);
                  }
                  return _bangunWidgetVideoDetail(snapshot.data);
                } else if (snapshot.hasError) {
                  return _bangunWidgetError(snapshot.error);
                } else {
                  return _bangunWidgetLoading();
                }
              },
            ),
            expandedHeight: 200.0, // posisi tombol play
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Style.Warna.mainColor,
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    film.title.length > 40
                        ? film.title.substring(0, 37) + "..."
                        : film.title,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  background: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/original/" +
                                    film.backPoster),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [
                                0.1,
                                0.9
                              ],
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.0)
                              ]),
                        ),
                      ),
                      // Tombol Play di Tengah
                      Positioned(
                        bottom: 0.0,
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: GestureDetector(
                          onTap: () {
                            // _bangunWidgetVideoDetail(data);
                          },
                          child: Icon(
                            FontAwesomeIcons.playCircle,
                            color: Colors.cyan[600],
                            size: 41.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Rating angka
                            Text(
                              film.rating.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            // Rating Bintang
                            RatingBar(
                              itemSize: 10.0,
                              initialRating: film.rating / 2,
                              ratingWidget: RatingWidget(
                                empty: Icon(
                                  EvaIcons.star,
                                  color: Colors.cyan[500],
                                ),
                                full: Icon(
                                  EvaIcons.star,
                                  color: Colors.cyan[500],
                                ),
                                half: Icon(
                                  EvaIcons.star,
                                  color: Colors.cyan[500],
                                ),
                              ),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Text(
                          "OVERVIEW",
                          style: TextStyle(
                              color: Colors.green[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      // overview
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          film.overview,
                          style: TextStyle(
                              color: Colors.white, fontSize: 12.0, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoFilm(
                        id: film.id,
                      ),
                      Aktor(
                        id: film.id,
                      ),
                      SimilarFilms(id: film.id)
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Loading
  Widget _bangunWidgetLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }

  // Error
  Widget _bangunWidgetError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Terjadi kesalahan: $error")],
      ),
    );
  }

  // widget video detail
  Widget _bangunWidgetVideoDetail(ResponVideo data) {
    List<Video> videos = data.videos;
    return FloatingActionButton(
      backgroundColor: Style.Warna.thirdColor,
      child: Icon(Icons.play_arrow),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayer(
              controller: YoutubePlayerController(
                initialVideoId: videos[0].key,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                  disableDragSeek: false,
                  loop: false,
                  isLive: false,
                  // forceHideAnnotation: true,
                  forceHD: true,
                  enableCaption: false,
                ),
              ),
            ),
            // fullscreenDialog: true,
          ),
        );
      },
    );
  }
}
