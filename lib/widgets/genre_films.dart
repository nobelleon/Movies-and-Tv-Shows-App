import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:movies_n_tvshows_app/models/film.dart';
import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GenreFilms extends StatefulWidget {
  final List<Film> films;
  const GenreFilms({Key key, this.films}) : super(key: key);

  @override
  _GenreFilmsState createState() => _GenreFilmsState(films);
}

class _GenreFilmsState extends State<GenreFilms> {
  final List<Film> films;

  _GenreFilmsState(this.films);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: films.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  films[index].poster == null
                      ? Hero(
                          tag: films[index].id,
                          child: Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: new BoxDecoration(
                              color: Style.Warna.secondColor,
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
                          ),
                        )
                      : Hero(
                          tag: films[index].id,
                          child: Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w200/" +
                                            films[index].poster)),
                              )),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      films[index].title,
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
                        films[index].rating.toString(),
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
                        initialRating: films[index].rating / 2,
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
