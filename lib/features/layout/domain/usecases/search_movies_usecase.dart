import '../entities/search_movie_entity.dart';
import '../repositories/search_repository.dart';

class SearchMoviesUseCase {
  final SearchRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<List<SearchMovieEntity>> call(String query) {
    return repository.searchMovies(query);
  }
}