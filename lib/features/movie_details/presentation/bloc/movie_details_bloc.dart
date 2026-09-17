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
    on<GetParentalGuidesEvent>(_onGetParentalGuides);
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
          parentalLoading: true,
        ),
      );

      add(GetSimilarMoviesEvent(event.movieId));
      add(GetParentalGuidesEvent(event.movieId));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }

  Future<void> _onGetSimilarMovies(
      GetSimilarMoviesEvent event,
      Emitter<MovieDetailsState> emit,
      ) async {
    try {
      final movies =
      await getMovieDetailsUseCase.getSimilarMovies(
        event.movieId,
      );

      print('SIMILAR MOVIES COUNT: ${movies.length}');

      final currentState = state;

      if (currentState is! MovieDetailsSuccess) {
        return;
      }

      emit(
        currentState.copyWith(
          similarMovies: movies,
          similarLoading: false,
          similarError: null,
        ),
      );
    } catch (e) {
      final currentState = state;

      if (currentState is! MovieDetailsSuccess) {
        return;
      }

      emit(
        currentState.copyWith(
          similarLoading: false,
          similarError: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetParentalGuides(
      GetParentalGuidesEvent event,
      Emitter<MovieDetailsState> emit,
      ) async {
    try {
      final guides =
      await getMovieDetailsUseCase.getParentalGuides(
        event.movieId,
      );

      final currentState = state;

      if (currentState is! MovieDetailsSuccess) {
        return;
      }

      emit(
        currentState.copyWith(
          parentalGuides: guides,
          parentalLoading: false,
          parentalError: null,
        ),
      );
    } catch (e) {
      final currentState = state;

      if (currentState is! MovieDetailsSuccess) {
        return;
      }

      emit(
        currentState.copyWith(
          parentalLoading: false,
          parentalError: e.toString(),
        ),
      );
    }
  }
}