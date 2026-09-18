import '../entities/search_movie_entity.dart';

abstract class SearchRepository {
  Future<List<SearchMovieEntity>> searchMovies(String query);
}