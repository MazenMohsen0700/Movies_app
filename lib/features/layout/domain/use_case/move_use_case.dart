import 'package:injectable/injectable.dart';
import 'package:movie_app/features/layout/domain/repo/repo.dart';

import '../../../../core/api_resuit/api_resuit.dart';
import '../entity/move_entity.dart';

@injectable
class MoveUseCase {
  Repo repo;

  MoveUseCase(this.repo);

  Future<ApiResuit<List<MoveEntity>>> call(String genre) async {
    return await repo.getMovies(genre);
  }
}