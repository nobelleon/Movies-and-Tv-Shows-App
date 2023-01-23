import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_n_tvshows_app/bloc/get_tv_videos_bloc.dart';
import 'package:movies_n_tvshows_app/layar/video_player.dart';
import 'package:movies_n_tvshows_app/models/respon_video_tv.dart';
import 'package:movies_n_tvshows_app/models/video_tv.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/tv.dart';
import '../widgets/aktor.dart';
import '../widgets/info_film.dart';
import '../widgets/similar_films.dart';

class LayarDetailTv extends StatefulWidget {
  final Tv tv;

  const LayarDetailTv({Key key, this.tv}) : super(key: key);

  @override
  State<LayarDetailTv> createState() => _LayarDetailTvState(tv);
}

class _LayarDetailTvState extends State<LayarDetailTv> {
  final Tv tv;

  _LayarDetailTvState(this.tv);

  @override
  void initState() {
    super.initState();
    tvVideosBloc..getTvVideos(tv.id);
  }

  @override
  void dispose() {
    super.dispose();
    tvVideosBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Warna.fourthColor, // mainColor
      body: Builder(
        builder: (context) {
          return SliverFab(
            floatingPosition: FloatingPosition(right: 20),
            floatingWidget: StreamBuilder<ResponVideoTv>(
              stream: tvVideosBloc.subject.stream,
              builder: (context, AsyncSnapshot<ResponVideoTv> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return _bangunWidgetError(snapshot.data.error);
                  }
                  return _bangunWidgetTvShowsDetail(snapshot.data);
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
                    tv.name.length > 40
                        ? tv.name.substring(0, 37) + "..."
                        : tv.name,
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
                                    tv.backPoster),
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
                              tv.rating.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            // Rating Bintang
                            RatingBar(
                              itemSize: 10.0,
                              initialRating: tv.rating / 2,
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
                          tv.overview,
                          style: TextStyle(
                              color: Colors.white, fontSize: 12.0, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoFilm(
                        id: tv.id,
                      ),
                      Aktor(
                        id: tv.id,
                      ),
                      SimilarFilms(id: tv.id)
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

  // widget tv shows detail
  Widget _bangunWidgetTvShowsDetail(ResponVideoTv data) {
    List<VideoTv> _videoTvs = data.videoTvs;
    return FloatingActionButton(
      backgroundColor: Style.Warna.thirdColor,
      child: Icon(Icons.play_arrow),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayer(
              controller: YoutubePlayerController(
                initialVideoId: _videoTvs[0].key,
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
