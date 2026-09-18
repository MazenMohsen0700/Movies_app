import 'package:dio/dio.dart';

class SearchRemoteDataSource {
  final Dio dio = Dio();

  Future<Response> searchMovies(String query) async {
    final response = await dio.get(
      'https://movies-api.accel.li/api/v2/list_movies.json',
      queryParameters: {
        'query_term': query,
      },
    );

    return response;
  }
}