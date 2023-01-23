import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/models/aliran_tv.dart';
import 'package:movies_n_tvshows_app/style/warna.dart' as Style;
import 'package:movies_n_tvshows_app/widgets/tvs_by_airing.dart';

import '../bloc/get_tv_popular_bloc.dart';

class TvAiringList extends StatefulWidget {
  final List<AliranTv> tvAirings;

  const TvAiringList({Key key, this.tvAirings}) : super(key: key);

  @override
  State<TvAiringList> createState() => _TvAiringListState(tvAirings);
}

class _TvAiringListState extends State<TvAiringList>
    with SingleTickerProviderStateMixin {
  final List<AliranTv> tvAirings;
  TabController _tabController;

  _TvAiringListState(this.tvAirings);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tvAirings.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        tvsPopularBloc..drainStream();
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
        length: tvAirings.length,
        child: Scaffold(
          backgroundColor: Style.Warna.fourthColor, // mainColor
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Style.Warna.fourthColor, // .mainColor
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Style.Warna.thirdColor, // secondColor
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: Style.Warna.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: tvAirings.map((AliranTv tvAiring) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                    child: new Text(
                      tvAiring.name.toUpperCase(),
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
            children: tvAirings.map((AliranTv tvAiring) {
              return TvsByAiring(
                tvAiringId: tvAiring.id,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
