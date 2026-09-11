import 'package:flutter/material.dart';



import '../../../../core/widgets/movie_card.dart';
import '../../../browse_movies/date/models/movie_model.dart';

class SimilarMoviesWidget extends StatelessWidget {
  const SimilarMoviesWidget({super.key});

  final List<MovieModel> similarMovies = const [
    MovieModel(
      imagePath: 'assets/images/Doctor Strange 1 (2).png',
      rating: '7.7',
    ),
    MovieModel(
      imagePath: 'assets/similar/captain_america.png',
      rating: '7.7',
    ),
    MovieModel(
      imagePath: 'assets/similar/avengers.png',
      rating: '7.7',
    ),
    MovieModel(
      imagePath: 'assets/similar/civil_war.png',
      rating: '7.7',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
            itemCount: similarMovies.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final movie = similarMovies[index];

              return MovieCard(
                imagePath: movie.imagePath,
                rating: movie.rating,
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}