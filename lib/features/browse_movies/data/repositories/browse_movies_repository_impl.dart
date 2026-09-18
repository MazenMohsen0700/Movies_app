import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/browse_movies_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../models/movie_model.dart';

class BrowseMoviesRepositoryImpl
    implements BrowseMoviesRepository {
  final RemoteDataSource remoteDataSource;

  BrowseMoviesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieEntity>> getMoviesByGenre(String genre) async {
    final response =
    await remoteDataSource.getMoviesByGenre(genre);

    final moviesJson =
    response.data['data']['movies'] as List;

    return moviesJson.map((movieJson) {
      final model = MovieModel.fromJson(movieJson);

      return MovieEntity(
        id: model.id,
        title: model.title,
        imagePath: model.imagePath,
        rating: model.rating,
        genres: model.genres,
      );
    }).toList();
  }

  Future<Set<String>> getGenres() async {
    final response =
    await remoteDataSource.getMovies();

    final moviesJson =
    response.data['data']['movies'] as List;

    final Set<String> genres = {};

    for (final movieJson in moviesJson) {
      final model = MovieModel.fromJson(movieJson);

      for (final genre in model.genres) {
        genres.add(genre);
      }
    }

    return genres;
  }
}