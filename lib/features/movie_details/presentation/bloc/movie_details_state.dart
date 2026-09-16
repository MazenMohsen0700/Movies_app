import '../../domain/entities/movie_details_entity.dart';
import '../../domain/entities/similar_movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsEntity movie;
  final List<SimilarMovieEntity> similarMovies;
  final bool similarLoading;
  final String? similarError;

  MovieDetailsSuccess({
    required this.movie,
    this.similarMovies = const [],
    this.similarLoading = false,
    this.similarError,
  });

  MovieDetailsSuccess copyWith({
    MovieDetailsEntity? movie,
    List<SimilarMovieEntity>? similarMovies,
    bool? similarLoading,
    String? similarError,
  }) {
    return MovieDetailsSuccess(
      movie: movie ?? this.movie,
      similarMovies: similarMovies ?? this.similarMovies,
      similarLoading: similarLoading ?? this.similarLoading,
      similarError: similarError,
    );
  }
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}