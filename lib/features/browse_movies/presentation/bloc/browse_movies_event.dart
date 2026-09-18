abstract class BrowseMoviesEvent {}

class GetGenresEvent extends BrowseMoviesEvent {}

class GetMoviesByGenreEvent extends BrowseMoviesEvent {
  final String genre;

  GetMoviesByGenreEvent(this.genre);
}