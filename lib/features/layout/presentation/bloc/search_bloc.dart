import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/search_movies_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  SearchBloc(this.searchMoviesUseCase)
      : super(SearchInitial()) {
    on<SearchMoviesEvent>(_onSearchMovies);
  }

  Future<void> _onSearchMovies(
      SearchMoviesEvent event,
      Emitter<SearchState> emit,
      ) async {
    if (event.query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final movies =
      await searchMoviesUseCase(event.query);

      emit(SearchSuccess(movies));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}