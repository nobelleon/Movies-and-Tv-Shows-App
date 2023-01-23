import 'package:movies_n_tvshows_app/bloc/get_genres_bloc.dart';
import 'package:movies_n_tvshows_app/models/aliran.dart';
import 'package:movies_n_tvshows_app/models/respon_aliran.dart';
import 'package:movies_n_tvshows_app/widgets/genres_list.dart';
import 'package:flutter/material.dart';

class LayarGenre extends StatefulWidget {
  @override
  _LayarGenreState createState() => _LayarGenreState();
}

class _LayarGenreState extends State<LayarGenre> {
  @override
  void initState() {
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResponAliran>(
        stream: genresBloc.subject.stream,
        builder: (context, AsyncSnapshot<ResponAliran> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _bangunWidgetError(snapshot.data.error);
            }
            return _bangunWidgetGenre(snapshot.data);
          } else if (snapshot.hasError) {
            return _bangunWidgetError(snapshot.error);
          } else {
            return _bangunWidgetLoading();
          }
        });
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

  // Widget Genre
  Widget _bangunWidgetGenre(ResponAliran data) {
    List<Aliran> genres = data.alirans;
    print(genres);
    if (genres.length == 0) {
      //
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
      return GenresList(
        genres: genres,
      );
  }
}
