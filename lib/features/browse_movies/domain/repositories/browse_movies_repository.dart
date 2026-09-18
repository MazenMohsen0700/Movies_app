import '../entities/movie_entity.dart';

abstract class BrowseMoviesRepository {
  Future<List<MovieEntity>> getMoviesByGenre(String genre);
  Future<Set<String>> getGenres();
}