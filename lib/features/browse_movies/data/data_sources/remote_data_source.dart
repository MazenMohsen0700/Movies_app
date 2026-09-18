import 'package:dio/dio.dart';

class RemoteDataSource {
  final Dio dio = Dio();

  Future<Response> getMovies() async {
    final response = await dio.get(
      'https://movies-api.accel.li/api/v2/list_movies.json',
    );

    return response;
  }

  Future<Response> getMoviesByGenre(String genre) async {
    final response = await dio.get(
      'https://movies-api.accel.li/api/v2/list_movies.json',
      queryParameters: {
        'genre': genre,
      },
    );

    return response;
  }
}