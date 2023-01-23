import 'package:movies_n_tvshows_app/models/detail_tv.dart';

class ResponseDetailTv {
  final DetailTv detailTv;
  final String error;

  ResponseDetailTv(this.detailTv, this.error);

  ResponseDetailTv.fromJson(Map<String, dynamic> json)
      : detailTv = DetailTv.fromJson(json),
        error = "";

  ResponseDetailTv.withError(String errorValue)
      : detailTv = DetailTv(null, null, null, null, null, "", null),
        error = errorValue;
}
