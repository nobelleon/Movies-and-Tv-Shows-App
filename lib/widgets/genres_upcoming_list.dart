import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/models/aliran.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;
import 'package:movies_n_tvshows_app/widgets/films_by_genre_upcoming.dart';

import '../bloc/get_films_upcoming_bloc.dart';

class GenresUpcomingList extends StatefulWidget {
  final List<Aliran> genres;
  const GenresUpcomingList({Key key, this.genres}) : super(key: key);

  @override
  State<GenresUpcomingList> createState() => _GenresUpcomingListState(genres);
}

class _GenresUpcomingListState extends State<GenresUpcomingList>
    with SingleTickerProviderStateMixin {
  final List<Aliran> genres;
  TabController _tabController;

  _GenresUpcomingListState(this.genres);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        filmsUpcomingBloc..drainStream();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Warna.fifthColor, // mainColor
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Style.Warna.fifthColor, // .mainColor
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.purpleAccent, // secondColor
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: Style.Warna.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map((Aliran genre) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                    child: new Text(
                      genre.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((Aliran genre) {
              return FilmsByGenreUpcoming(
                genreId: genre.id,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
