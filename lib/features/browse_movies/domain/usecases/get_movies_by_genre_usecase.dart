import '../entities/movie_entity.dart';
import '../repositories/browse_movies_repository.dart';

class GetMoviesByGenreUseCase {
  final BrowseMoviesRepository repository;

  GetMoviesByGenreUseCase(this.repository);

  Future<List<MovieEntity>> call(String genre) {
    return repository.getMoviesByGenre(genre);
  }
  Future<Set<String>> getGenres() {
    return repository.getGenres();
  }
}