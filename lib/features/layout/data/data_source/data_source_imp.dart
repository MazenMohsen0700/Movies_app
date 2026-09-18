import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/service/api_service.dart';
import 'package:movie_app/features/layout/data/data_source/data_source.dart';

@Injectable(as: DataSource)
class DataSourceImp implements DataSource {
  ApiService apiService;
  DataSourceImp(this.apiService);
  @override
  Future<Response> getMovies(String genre) async {
    var response =  await apiService.dio.get("list_movies.json" ,  queryParameters: {
      if (genre != "All") "genre": genre,
      "sort_by" : "year",
      "order_by" : "desc",
          "limit" : "50"
    });
    return response;
  }
}