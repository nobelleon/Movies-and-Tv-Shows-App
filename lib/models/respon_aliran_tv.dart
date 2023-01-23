import 'package:movies_n_tvshows_app/models/aliran_tv.dart';

class ResponAliranTv {
  final List<AliranTv> aliranTvs;
  final String error;

  ResponAliranTv(this.aliranTvs, this.error);

  ResponAliranTv.fromJson(Map<String, dynamic> json)
      : aliranTvs = (json["genres"] as List)
            .map((i) => new AliranTv.fromJson(i))
            .toList(),
        error = "";

  ResponAliranTv.withError(String errorValue)
      : aliranTvs = [],
        error = errorValue;
}
