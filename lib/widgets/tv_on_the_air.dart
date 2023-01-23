import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/models/respon_tv.dart';
import 'package:movies_n_tvshows_app/models/tv.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';

import '../bloc/get_tv_on_the_air_bloc.dart';

class TvOnTheAir extends StatefulWidget {
  const TvOnTheAir({Key key});

  @override
  State<TvOnTheAir> createState() => _TvOnTheAirState();
}

class _TvOnTheAirState extends State<TvOnTheAir> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    tvOnTheAirBloc..getTvs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Center(
            child: Text(
              "** TV SHOWS ** ",
              style: TextStyle(
                  color: Colors.green[600], //Style.Warna.titleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        StreamBuilder<ResponTv>(
          stream: tvOnTheAirBloc.subject.stream,
          builder: (context, AsyncSnapshot<ResponTv> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _bangunwidgetError(snapshot.data.error);
              }
              return _bangunWidgetTvOnTheAir(snapshot.data);
            } else if (snapshot.hasError) {
              return _bangunwidgetError(snapshot.error);
            } else {
              return _bangunWidgetLoading();
            }
          },
        ),
      ],
    );
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
  Widget _bangunWidgetTvOnTheAir(ResponTv data) {
    List<Tv> tvs = data.tvs;
    if (tvs.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tidak Ada Tv Shows Lagi..",
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
          length: tvs.take(7).length, // 7 film
          indicatorSpace: 8.0,
          padding: EdgeInsets.all(5.0),
          indicatorColor: Colors.purple,
          indicatorSelectorColor: Colors.amber,
          shape: IndicatorShape.circle(size: 5.0),
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: tvs.take(7).length, // 7 film
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  // Image back Poster
                  Hero(
                    tag: tvs[index].id,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/original/" +
                                  tvs[index].backPoster),
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
                            tvs[index].name,
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
