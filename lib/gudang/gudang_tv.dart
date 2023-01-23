import 'package:dio/dio.dart';
import 'package:movies_n_tvshows_app/models/respon_aliran_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_detail_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_tv.dart';
import 'package:movies_n_tvshows_app/models/respon_video_tv.dart';
import 'package:movies_n_tvshows_app/models/tv_response_people.dart';

class GudangTv {
  final String apiKey = "1e8632d3f90a3b8c1a52c693fec1a5bb";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio dio = Dio();

  var getTopRatedTvUrl = '$mainUrl/tv/top_rated';
  var getPopularTvUrl = '$mainUrl/tv/popular';
  var getTvOnTheAirUrl = '$mainUrl/tv/on_the_air';
  var getTvAiringTodayUrl = '$mainUrl/tv/airing_today';
  var getTrendingTvUrl = '$mainUrl/person/popular';
  var tvUrl = "$mainUrl/tv";

  // Top Rated Tv URL
  Future<ResponTv> getTvs() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
    };

    try {
      Response response =
          await dio.get(getTopRatedTvUrl, queryParameters: params);
      return ResponTv.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResponTv.withError("$error");
    }
  }

  // Tv Popular URL (Can Playing Tv Trailer)
  Future<ResponTv> getTvsPopular() async {
    var params = {
      "api_key": "1e8632d3f90a3b8c1a52c693fec1a5bb",
      "language": "en-US",
      "page": 1,
      //"with_genres": id
    };
    try {
      Response response =
          await dio.get(getPopularTvUrl, queryParameters: params);
      return ResponTv.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResponTv.withError("$error");
    }
  }

  // Tv on the air URL
  Future<ResponTv> getTvOnTheAir() async {
    var params = {
      "api_key": "1e8632d3f90a3b8c1a52c693fec1a5bb",
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response =
          await dio.get(getTvOnTheAirUrl, queryParameters: params);
      return ResponTv.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResponTv.withError("$error");
    }
  }

  // Tv Airing Today URL
  Future<ResponTv> getTvAiringToday() async {
    var params = {
      "api_key": "1e8632d3f90a3b8c1a52c693fec1a5bb",
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response =
          await dio.get(getTvAiringTodayUrl, queryParameters: params);
      return ResponTv.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResponTv.withError("$error");
    }
  }

  // Trending Tv URL (Persons)
  Future<TvResponsePeople> getPersonsTvShow() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response =
          await dio.get(getTrendingTvUrl, queryParameters: params);
      return TvResponsePeople.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponsePeople.withError("$error");
    }
  }

  //Tv Detail
  Future<ResponseDetailTv> getTvDetail(int id) async {
    var params = {
      "api_key": "1e8632d3f90a3b8c1a52c693fec1a5bb",
      "language": "en-US",
    };
    try {
      Response response =
          await dio.get(tvUrl + "/$id", queryParameters: params);
      return ResponseDetailTv.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResponseDetailTv.withError("$error");
    }
  }

  // Tv Video
  Future<ResponVideoTv> getTvVideos(int id) async {
    var params = {
      "api_key": "1e8632d3f90a3b8c1a52c693fec1a5bb",
      "language": "en-US",
    };
    try {
      Response response =
          await dio.get(tvUrl + "/$id" + "/videos", queryParameters: params);
      return ResponVideoTv.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResponVideoTv.withError("$error");
    }
  }
}
