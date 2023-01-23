import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_n_tvshows_app/models/respon_tv.dart';
import 'package:movies_n_tvshows_app/models/tv.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;

import '../bloc/get_tv_list_bloc.dart';

class TvShowsTerbaik extends StatefulWidget {
  const TvShowsTerbaik({Key key});

  @override
  State<TvShowsTerbaik> createState() => _TvShowsTerbaikState();
}

class _TvShowsTerbaikState extends State<TvShowsTerbaik> {
  @override
  void initState() {
    super.initState();
    tvsListBloc..getTvs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "TV SHOWS TERBAIK",
            style: TextStyle(
                color: Colors.green[600], //Style.Warna.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<ResponTv>(
          stream: tvsListBloc.subject.stream,
          builder: (context, AsyncSnapshot<ResponTv> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _bangunWidgetError(snapshot.data.error);
              }
              return _bangunWidgetTvShowsTerbaik(snapshot.data);
            } else if (snapshot.hasError) {
              return _bangunWidgetError(snapshot.error);
            } else {
              return _bangunWidgetLoading();
            }
          },
        )
      ],
    );
  }

  // Loading
  Widget _bangunWidgetLoading() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  // Error
  Widget _bangunWidgetError(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Terjadi kesalahan: $error"),
      ],
    ));
  }

  // widget Film Terbaik
  Widget _bangunWidgetTvShowsTerbaik(ResponTv data) {
    List<Tv> tvShows = data.tvs;
    if (tvShows.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Tidak ada lagi film",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tvShows.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: tvShows[index].id,
                      child: Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/w200/" +
                                  tvShows[index].poster,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        tvShows[index].name,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          tvShows[index].rating.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar(
                          ratingWidget: RatingWidget(
                            empty: Icon(
                              EvaIcons.star,
                              color: Style.Warna.thirdColor,
                            ),
                            full: Icon(
                              EvaIcons.star,
                              color: Style.Warna.thirdColor,
                            ),
                            half: Icon(
                              EvaIcons.star,
                              color: Style.Warna.thirdColor,
                            ),
                          ),
                          itemSize: 8.0,
                          initialRating: tvShows[index].rating / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
