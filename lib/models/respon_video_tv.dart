import 'package:movies_n_tvshows_app/models/video_tv.dart';

class ResponVideoTv {
  final List<VideoTv> videoTvs;
  final String error;

  ResponVideoTv(this.videoTvs, this.error);

  ResponVideoTv.fromJson(Map<String, dynamic> json)
      : videoTvs = (json["results"] as List)
            .map((i) => new VideoTv.fromJson(i))
            .toList(),
        error = "";

  ResponVideoTv.withError(String errorValue)
      : videoTvs = [],
        error = errorValue;
}
