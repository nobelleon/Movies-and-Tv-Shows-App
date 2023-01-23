import 'package:movies_n_tvshows_app/models/aliran_tv.dart';
import 'package:movies_n_tvshows_app/models/perusahaan_tv.dart';

class DetailTv {
  final int id;
  final bool inProduction;
  final int numberOfEpisodes;
  final List<AliranTv> genres;
  final List<PerusahaanTv> companies;
  final String status;
  final int voteCount;

  DetailTv(
    this.id,
    this.inProduction,
    this.numberOfEpisodes,
    this.genres,
    this.companies,
    this.status,
    this.voteCount,
  );

  DetailTv.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        inProduction = json["in_production"],
        numberOfEpisodes = json["number_of_episodes"],
        genres = (json["genres"] as List) // genres
            .map((i) => new AliranTv.fromJson(i))
            .toList(),
        companies = (json["production_companies"] as List)
            .map((i) => new PerusahaanTv.fromJson(i))
            .toList(),
        status = json["status"],
        voteCount = json["vote_count"];
}
