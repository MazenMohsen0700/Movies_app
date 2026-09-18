import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_movies_by_genre_usecase.dart';
import 'browse_movies_event.dart';
import 'browse_movies_state.dart';

class BrowseMoviesBloc
    extends Bloc<BrowseMoviesEvent, BrowseMoviesState> {
  final GetMoviesByGenreUseCase getMoviesByGenreUseCase;

  BrowseMoviesBloc(this.getMoviesByGenreUseCase)
      : super(BrowseMoviesInitial()) {
    on<GetGenresEvent>(_onGetGenres);
    on<GetMoviesByGenreEvent>(_onGetMoviesByGenre);
  }

  Future<void> _onGetGenres(
      GetGenresEvent event,
      Emitter<BrowseMoviesState> emit,
      ) async {
    emit(BrowseMoviesLoading());

    try {
      final genres =
      await getMoviesByGenreUseCase.getGenres();

      if (genres.isEmpty) {
        emit(
          BrowseMoviesError(
            'No genres found',
          ),
        );
        return;
      }

      final selectedGenre = genres.first;

      final movies =
      await getMoviesByGenreUseCase(selectedGenre);

      emit(
        BrowseMoviesSuccess(
          movies: movies,
          genres: genres,
          selectedGenre: selectedGenre,
        ),
      );
    } catch (e) {
      emit(BrowseMoviesError(e.toString()));
    }
  }

  Future<void> _onGetMoviesByGenre(
      GetMoviesByGenreEvent event,
      Emitter<BrowseMoviesState> emit,
      ) async {
    final currentState = state;

    if (currentState is BrowseMoviesSuccess) {
      emit(BrowseMoviesLoading());

      try {
        final movies =
        await getMoviesByGenreUseCase(event.genre);

        emit(
          BrowseMoviesSuccess(
            movies: movies,
            genres: currentState.genres,
            selectedGenre: event.genre,
          ),
        );
      } catch (e) {
        emit(BrowseMoviesError(e.toString()));
      }
    }
  }
}