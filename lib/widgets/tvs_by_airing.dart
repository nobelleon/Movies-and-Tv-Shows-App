import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_n_tvshows_app/bloc/get_tv_popular_bloc.dart';
import 'package:movies_n_tvshows_app/layar/layar_detail_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_tv.dart';
import 'package:movies_n_tvshows_app/models/tv.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;

class TvsByAiring extends StatefulWidget {
  final int tvAiringId;

  const TvsByAiring({Key key, this.tvAiringId}) : super(key: key);

  @override
  State<TvsByAiring> createState() => _TvsByAiringState(tvAiringId);
}

class _TvsByAiringState extends State<TvsByAiring> {
  final int tvAiringId;

  _TvsByAiringState(this.tvAiringId);

  @override
  void initState() {
    super.initState();
    tvsPopularBloc..getTvsPopular();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResponTv>(
      stream: tvsPopularBloc.subject.stream,
      builder: (context, AsyncSnapshot<ResponTv> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _bangunWidgetError(snapshot.data.error);
          }
          return _bangunWidgetTvByAiring(snapshot.data);
        } else if (snapshot.hasError) {
          return _bangunWidgetError(snapshot.error);
        } else {
          return _bangunWidgetLoading();
        }
      },
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
      ),
    );
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

  // widget Film by Genre
  Widget _bangunWidgetTvByAiring(ResponTv data) {
    List<Tv> _tvs = data.tvs;
    if (_tvs.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Tidak Ada Film Lagi..",
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
          itemCount: _tvs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LayarDetailTv(tv: _tvs[index]),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _tvs[index].poster == null //
                        ? Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: new BoxDecoration(
                              color: Style.Warna.thirdColor, // secondColor
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  EvaIcons.filmOutline,
                                  color: Colors.white,
                                  size: 60.0,
                                )
                              ],
                            ),
                          )
                        : Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/" +
                                        _tvs[index].poster),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        _tvs[index].name,
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
                          _tvs[index].rating.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        // Rating
                        RatingBar.builder(
                          itemSize: 8.0,
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.cyan[500],
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
