import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/data_sources/remote_data_source.dart';
import '../../data/repositories/movie_details_repository_impl.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';
import '../widgets/movie_header_widget.dart';
import '../widgets/screen_shots_widget.dart';
import '../widgets/similar_movies_widget.dart';
import '../widgets/cast_and_genres_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

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
        ..add(GetMovieDetailsEvent(movieId)),
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
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  MovieHeaderWidget(
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

                   SimilarMoviesWidget(movieId: movieId,),

                  const SizedBox(height: 20),

                  CastAndGenresWidget(
                    description:state.movie.description,
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