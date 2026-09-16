import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_movie_details_usecase.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc
    extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  MovieDetailsBloc(this.getMovieDetailsUseCase)
      : super(MovieDetailsInitial()) {
    on<GetMovieDetailsEvent>(_onGetMovieDetails);
    on<GetSimilarMoviesEvent>(_onGetSimilarMovies);
  }

  Future<void> _onGetMovieDetails(
      GetMovieDetailsEvent event,
      Emitter<MovieDetailsState> emit,
      ) async {
    emit(MovieDetailsLoading());

    try {
      final movie =
      await getMovieDetailsUseCase(event.movieId);

      emit(
        MovieDetailsSuccess(
          movie: movie,
          similarLoading: true,
        ),
      );

      add(GetSimilarMoviesEvent(event.movieId));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }

  Future<void> _onGetSimilarMovies(
      GetSimilarMoviesEvent event,
      Emitter<MovieDetailsState> emit,
      ) async {
    final currentState = state;

    if (currentState is! MovieDetailsSuccess) {
      return;
    }

    try {
      final movies =
      await getMovieDetailsUseCase.getSimilarMovies(
        event.movieId,
      );

      emit(
        currentState.copyWith(
          similarMovies: movies,
          similarLoading: false,
        ),
      );
    } catch (e) {
      emit(
        currentState.copyWith(
          similarLoading: false,
          similarError: e.toString(),
        ),
      );
    }
  }
}