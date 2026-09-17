abstract class MovieDetailsEvent {}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;

  GetMovieDetailsEvent(this.movieId);
}

class GetSimilarMoviesEvent extends MovieDetailsEvent {
  final int movieId;

  GetSimilarMoviesEvent(this.movieId);
}
class GetParentalGuidesEvent extends MovieDetailsEvent {
  final int movieId;

  GetParentalGuidesEvent(this.movieId);
}