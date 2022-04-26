import 'package:dio/dio.dart';

import '../model/movie_response.dart';

class MovieRepository{
   final String apiKey = "2e1261e8a26825b451ce77b008a3d2f9";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var getNowPlayingMoviesApi = '$mainUrl/movie/now_playing';
  var getPopularMoviesApi = '$mainUrl/movie/popular';

   Future<MovieResponse> getNowPlaying(int page) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": page};
    try {
      Response response =
          await _dio.get(getNowPlayingMoviesApi, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }

   Future<MovieResponse> getPopuparMovies(int page) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": page};
    try {
      Response response =
          await _dio.get(getPopularMoviesApi, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return MovieResponse.withError("Error: $error, StackTrace: $stacktrace");
    }
  }
}