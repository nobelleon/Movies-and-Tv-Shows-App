import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_n_tvshows_app/models/aliran_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_aliran_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_tv.dart';
import 'package:movies_n_tvshows_app/models/tv.dart';
import 'package:movies_n_tvshows_app/widgets/tv_airing_list.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;

import '../bloc/get_tv_airing_today_bloc.dart';

class TvAiringToday extends StatefulWidget {
  const TvAiringToday({Key key});

  @override
  State<TvAiringToday> createState() => _TvAiringTodayState();
}

class _TvAiringTodayState extends State<TvAiringToday> {
  @override
  void initState() {
    super.initState();
    tvAiringTodayBloc..getTvAiringToday();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "TV AIRING TODAY",
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
          stream: tvAiringTodayBloc.subject.stream,
          builder: (context, AsyncSnapshot<ResponTv> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _bangunWidgetError(snapshot.data.error);
              }
              return _bangunWidgetTvAiringToday(snapshot.data);
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
      ),
    );
  }

  // Widget Tv Airing Today
  // widget Film Terbaik
  Widget _bangunWidgetTvAiringToday(ResponTv data) {
    List<Tv> tvAiring = data.tvs;
    if (tvAiring.length == 0) {
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
          itemCount: tvAiring.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: tvAiring[index].id,
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
                                  tvAiring[index].poster,
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
                        tvAiring[index].name,
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
                          tvAiring[index].rating.toString(),
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
                          initialRating: tvAiring[index].rating / 2,
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
