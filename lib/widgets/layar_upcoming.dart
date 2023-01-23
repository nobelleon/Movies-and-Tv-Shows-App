import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/models/respon_aliran.dart';
import 'package:movies_n_tvshows_app/widgets/genres_list.dart';
import 'package:movies_n_tvshows_app/widgets/genres_upcoming_list.dart';

import '../bloc/get_upcoming_bloc.dart';
import '../models/aliran.dart';

class LayarUpcoming extends StatefulWidget {
  const LayarUpcoming({Key key});

  @override
  State<LayarUpcoming> createState() => _LayarUpcomingState();
}

class _LayarUpcomingState extends State<LayarUpcoming> {
  @override
  void initState() {
    super.initState();
    upcomingBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "FILM AKAN DATANG",
            style: TextStyle(
                color: Colors.green[600], //Style.Warna.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<ResponAliran>(
            stream: upcomingBloc.subject.stream,
            builder: (context, AsyncSnapshot<ResponAliran> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _bangunWidgetError(snapshot.data.error);
                }
                return _bangunWidgetUpcoming(snapshot.data);
              } else if (snapshot.hasError) {
                return _bangunWidgetError(snapshot.error);
              } else {
                return _bangunWidgetLoading();
              }
            })
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

  // Widget Genre
  Widget _bangunWidgetUpcoming(ResponAliran data) {
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
      return GenresUpcomingList(
        genres: genres,
      );
  }
}
