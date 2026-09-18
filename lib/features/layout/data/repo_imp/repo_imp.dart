import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/layout/data/model/response_model.dart';
import 'package:movie_app/features/layout/domain/entity/move_entity.dart';
import 'package:movie_app/features/layout/domain/repo/repo.dart';

import '../../../../core/api_resuit/api_resuit.dart';
import '../data_source/data_source.dart';

@Injectable(as: Repo)
class RepoImp implements Repo {

  DataSource dataSource;

  RepoImp(this.dataSource);

  @override
  Future<ApiResuit<List<MoveEntity>>> getMovies(String genre) async {
    try {
      Response response = await dataSource.getMovies(genre);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var model = ResponseModel.fromJson(response.data);
        print("MODEL MOVIES = ${model.data?.movies?.length}");
        var entity = model.data?.movies
            ?.map((move) => move.toEntity())
            .toList() ?? [];
        print("ENTITY MOVIES = ${entity.length}");
        return SuccessState(data:entity);
      }
      else {
        return ErrorState(errorMessage: response.statusMessage);
      }
    } on DioException catch (e) {
      return ErrorState(errorMessage: e.message);
    } catch (e){
      return ErrorState(errorMessage: e.toString());
    }
  }
}