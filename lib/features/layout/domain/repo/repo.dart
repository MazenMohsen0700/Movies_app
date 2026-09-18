import 'package:movie_app/core/api_resuit/api_resuit.dart';
import 'package:movie_app/features/layout/domain/entity/move_entity.dart';

abstract class Repo {
  Future<ApiResuit<List<MoveEntity>>> getMovies(String genre);


}
