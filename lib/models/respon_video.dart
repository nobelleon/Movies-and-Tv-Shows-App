import 'package:movies_n_tvshows_app/models/video.dart';

class ResponVideo {
  final List<Video> videos;
  final String error;

  ResponVideo(this.videos, this.error);

  ResponVideo.fromJson(Map<String, dynamic> json)
      : videos = (json["results"] as List)
            .map((i) => new Video.fromJson(i))
            .toList(),
        error = "";

  ResponVideo.withError(String errorValue)
      : videos = [],
        error = errorValue;
}
