import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/movie_card.dart';
import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_state.dart';
import '../screens/movie_details_screen.dart';

class SimilarMoviesWidget extends StatelessWidget {
  final int movieId;

  const SimilarMoviesWidget({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is! MovieDetailsSuccess) {
          return const SizedBox();
        }

        if (state.similarLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.similarError != null) {
          return Center(
            child: Text(
              state.similarError!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }

        final movies = state.similarMovies;

        if (movies.isEmpty) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Similar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            movieId: movie.id,
                          ),
                        ),
                      );
                    },
                    child: MovieCard(
                      imagePath: movie.image,
                      rating: movie.rating.toString(),
                      isNetworkImage: true,
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}