import 'package:movies_n_tvshows_app/bloc/get_film_detail_bloc.dart';
import 'package:movies_n_tvshows_app/models/detail_film.dart';
import 'package:movies_n_tvshows_app/models/respon_detail_film.dart';
import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;

class InfoFilm extends StatefulWidget {
  final int id;

  const InfoFilm({Key key, this.id}) : super(key: key);

  @override
  _InfoFilmState createState() => _InfoFilmState(id);
}

class _InfoFilmState extends State<InfoFilm> {
  final int id;

  _InfoFilmState(this.id);

  @override
  void initState() {
    super.initState();
    movieDetailBloc..getFilmDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResponDetailFilm>(
      stream: movieDetailBloc.subject.stream,
      builder: (context, AsyncSnapshot<ResponDetailFilm> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _bangunWidgetError(snapshot.data.error);
          }
          return _bangunWidgetDetailFilm(snapshot.data);
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
      children: [],
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

  // Detail Film
  Widget _bangunWidgetDetailFilm(ResponDetailFilm data) {
    DetailFilm detail = data.detailFilm;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "ANGGARAN",
                    style: TextStyle(
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    detail.budget.toString() + "\$",
                    style: TextStyle(
                        color: Style.Warna.secondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "DURASI",
                    style: TextStyle(
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.runtime.toString() + "min",
                      style: TextStyle(
                          color: Style.Warna.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "TANGGAL RILIS",
                    style: TextStyle(
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.releaseDate,
                      style: TextStyle(
                          color: Style.Warna.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "GENRES",
                style: TextStyle(
                    color: Colors.green[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 38.0,
                padding: EdgeInsets.only(right: 10.0, top: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: detail.genres.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border:
                                Border.all(width: 1.0, color: Colors.white)),
                        child: Text(
                          detail.genres[index].name,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
