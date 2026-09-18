import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/data_sources/remote_data_source.dart';
import  '../../data/data_sources/history_remote_data_sourse.dart';
import '../../data/repositories/movie_details_repository_impl.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';
import '../widgets/movie_header_widget.dart';
import '../widgets/screen_shots_widget.dart';
import '../widgets/similar_movies_widget.dart';
import '../widgets/cast_and_genres_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final HistoryRemoteDataSource historyDataSource =
  HistoryRemoteDataSource();

  bool historySaved = false;

  Future<void> _saveToHistory({
    required int movieId,
    required String title,
    required String imagePath,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    try {
      await historyDataSource.addToHistory(
        userId: user.uid,
        movieId: movieId,
        title: title,
        imagePath: imagePath,
      );

      debugPrint('Movie added to history');
    } catch (e) {
      debugPrint('History error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = RemoteDataSource();

    final repository = MovieDetailsRepositoryImpl(
      remoteDataSource,
    );

    final useCase = GetMovieDetailsUseCase(
      repository,
    );

    return BlocProvider(
      create: (_) => MovieDetailsBloc(useCase)
        ..add(GetMovieDetailsEvent(widget.movieId)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MovieDetailsError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is MovieDetailsSuccess) {
              if (!historySaved) {
                historySaved = true;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _saveToHistory(
                    movieId: widget.movieId,
                    title: state.movie.titleLong,
                    imagePath: state.movie.backgroundImage,
                  );
                });
              }

              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  MovieHeaderWidget(
                    movieId: widget.movieId,
                    title: state.movie.titleLong,
                    year: state.movie.year.toString(),
                    imagePath: state.movie.backgroundImage,
                    rating: state.movie.rating.toString(),
                    likesCount: state.movie.likeCount,
                    duration: state.movie.runtime.toString(),
                  ),

                  const SizedBox(height: 20),

                  ScreenShotsWidget(
                    screenshot1: state.movie.screenshot1,
                    screenshot2: state.movie.screenshot2,
                    screenshot3: state.movie.screenshot3,
                  ),

                  const SizedBox(height: 20),

                  SimilarMoviesWidget(
                    movieId: widget.movieId,
                  ),

                  const SizedBox(height: 20),

                  CastAndGenresWidget(
                    description: state.movie.description,
                    cast: state.movie.cast,
                    genres: state.movie.genres,
                  ),

                  const SizedBox(height: 30),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}