import 'package:dio/dio.dart';

class RemoteDataSource {
  final Dio dio = Dio();

  Future<Response> getMovieDetails(int movieId) async {

    final response = await dio.get(
      'https://movies-api.accel.li/api/v2/movie_details.json',
      queryParameters: {
        'movie_id': movieId,
        'with_images': true,
        'with_cast': true,
      },
    );

    return response;
  }
  Future<Response> getMovieSuggestions(int movieId) async {
    final response = await dio.get(
      'https://movies-api.accel.li/api/v2/movie_suggestions.json',
      queryParameters: {
        'movie_id': movieId,
      },
    );

    return response;
  }
  Future<Response> getMovieParentalGuides(int movieId) async {
    final response = await dio.get(
      'https://movies-api.accel.li/api/v2/movie_parental_guides.json',
      queryParameters: {
        'movie_id': movieId,
      },
    );

    return response;
  }
}