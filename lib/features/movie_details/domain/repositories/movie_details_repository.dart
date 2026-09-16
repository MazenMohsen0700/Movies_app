import '../entities/movie_details_entity.dart';
import '../entities/similar_movie_entity.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetailsEntity> getMovieDetails(int movieId);

  Future<List<SimilarMovieEntity>> getSimilarMovies(int movieId);
}