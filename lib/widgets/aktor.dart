import 'package:movies_n_tvshows_app/bloc/get_actor_bloc.dart';
import 'package:movies_n_tvshows_app/models/pemeran.dart';
import 'package:movies_n_tvshows_app/models/respon_pemeran.dart';
import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Aktor extends StatefulWidget {
  final int id;

  const Aktor({Key key, this.id}) : super(key: key);

  @override
  _AktorState createState() => _AktorState(id);
}

class _AktorState extends State<Aktor> {
  final int id;

  _AktorState(this.id);

  @override
  void initState() {
    super.initState();
    actorsBloc..getActors(id);
  }

  @override
  void dispose() {
    actorsBloc.drainStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "AKTOR FILM",
            style: TextStyle(
                color: Colors.green[600], // Style.Warna.titleColor
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<ResponPemeran>(
          stream: actorsBloc.subject.stream,
          builder: (context, AsyncSnapshot<ResponPemeran> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _bangunWidgetError(snapshot.data.error);
              }
              return _bangunWidgetActor(snapshot.data);
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

  Widget _bangunWidgetError(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Terjadi kesalahan: $error"),
      ],
    ));
  }

  // Widget Actor
  Widget _bangunWidgetActor(ResponPemeran data) {
    List<Pemeran> casts = data.pemeran;
    if (casts.length == 0) {
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
        height: 140.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: casts.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 100.0,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    casts[index].img == null
                        ? Hero(
                            tag: casts[index].id,
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
                            tag: casts[index].id,
                            child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w300/" +
                                              casts[index].img)),
                                )),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      casts[index].name,
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
                      casts[index].character,
                      maxLines: 2,
                      textAlign: TextAlign.center,
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
