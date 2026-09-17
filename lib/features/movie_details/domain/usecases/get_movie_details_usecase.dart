import '../entities/movie_details_entity.dart';
import '../entities/similar_movie_entity.dart';
import '../entities/parental_guide_entity.dart';
import '../repositories/movie_details_repository.dart';

class GetMovieDetailsUseCase {
  final MovieDetailsRepository repository;

  GetMovieDetailsUseCase(this.repository);

  Future<MovieDetailsEntity> call(int movieId) {
    return repository.getMovieDetails(movieId);
  }

  Future<List<SimilarMovieEntity>> getSimilarMovies(int movieId) {
    return repository.getSimilarMovies(movieId);
  }

  Future<List<ParentalGuideEntity>> getParentalGuides(int movieId) {
    return repository.getParentalGuides(movieId);
  }
}