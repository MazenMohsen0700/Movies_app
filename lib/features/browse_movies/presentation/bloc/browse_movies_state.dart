import '../../domain/entities/movie_entity.dart';

abstract class BrowseMoviesState {}

class BrowseMoviesInitial extends BrowseMoviesState {}

class BrowseMoviesLoading extends BrowseMoviesState {}

class BrowseMoviesSuccess extends BrowseMoviesState {
  final List<MovieEntity> movies;
  final Set<String> genres;
  final String selectedGenre;

  BrowseMoviesSuccess({
    required this.movies,
    required this.genres,
    required this.selectedGenre,
  });
}

class BrowseMoviesError extends BrowseMoviesState {
  final String message;

  BrowseMoviesError(this.message);
}