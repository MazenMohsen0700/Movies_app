import '../../domain/entities/movie_details_entity.dart';
import '../../domain/entities/similar_movie_entity.dart';
import '../../domain/entities/parental_guide_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsEntity movie;

  final List<SimilarMovieEntity> similarMovies;
  final bool similarLoading;
  final String? similarError;

  final List<ParentalGuideEntity> parentalGuides;
  final bool parentalLoading;
  final String? parentalError;

  MovieDetailsSuccess({
    required this.movie,
    this.similarMovies = const [],
    this.similarLoading = false,
    this.similarError,
    this.parentalGuides = const [],
    this.parentalLoading = false,
    this.parentalError,
  });

  MovieDetailsSuccess copyWith({
    MovieDetailsEntity? movie,
    List<SimilarMovieEntity>? similarMovies,
    bool? similarLoading,
    String? similarError,
    List<ParentalGuideEntity>? parentalGuides,
    bool? parentalLoading,
    String? parentalError,
  }) {
    return MovieDetailsSuccess(
      movie: movie ?? this.movie,

      similarMovies:
      similarMovies ?? this.similarMovies,

      similarLoading:
      similarLoading ?? this.similarLoading,

      similarError:
      similarError ?? this.similarError,

      parentalGuides:
      parentalGuides ?? this.parentalGuides,

      parentalLoading:
      parentalLoading ?? this.parentalLoading,

      parentalError:
      parentalError ?? this.parentalError,
    );
  }
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}