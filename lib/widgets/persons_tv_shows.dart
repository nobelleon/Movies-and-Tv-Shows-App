import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_n_tvshows_app/models/person_tv.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;

import '../bloc/get_persons_tv_shows_bloc.dart';
import '../models/tv_response_people.dart';

class PersonsTvShows extends StatefulWidget {
  const PersonsTvShows({Key key});

  @override
  State<PersonsTvShows> createState() => _PersonsTvShowsState();
}

class _PersonsTvShowsState extends State<PersonsTvShows> {
  @override
  void initState() {
    super.initState();
    personsTvShowsBloc..getPersonsTvShow();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          child: Text(
            "TRENDING ARTIS TV SHOWS",
            style: TextStyle(
                color: Colors.green[600],
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<TvResponsePeople>(
          stream: personsTvShowsBloc.subject.stream,
          builder: (context, AsyncSnapshot<TvResponsePeople> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildHomeTvShowsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
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

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Terjadi kesalahan: $error"),
      ],
    ));
  }

  Widget _buildHomeTvShowsWidget(TvResponsePeople data) {
    List<PersonTv> personTvShows = data.personTvs;
    if (personTvShows.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Persons",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 116.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: personTvShows.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 100.0,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    personTvShows[index].profileImg == null
                        ? Hero(
                            tag: personTvShows[index].id,
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Style.Warna.secondColor),
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Hero(
                            tag: personTvShows[index].id,
                            child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w300/" +
                                              personTvShows[index].profileImg)),
                                )),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      personTvShows[index].name,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      "Trending for " + personTvShows[index].known,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.purple[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 7.0),
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
