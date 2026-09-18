import '../../domain/entities/search_movie_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_remote_data_source.dart';
import '../model/search_movie_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<SearchMovieEntity>> searchMovies(String query) async {
    final response =
    await remoteDataSource.searchMovies(query);

    final moviesJson =
    response.data['data']['movies'] as List;

    return moviesJson.map((movieJson) {
      final model =
      SearchMovieModel.fromJson(movieJson);

      return SearchMovieEntity(
        id: model.id,
        title: model.title,
        image: model.image,
        rating: model.rating,
      );
    }).toList();
  }
}