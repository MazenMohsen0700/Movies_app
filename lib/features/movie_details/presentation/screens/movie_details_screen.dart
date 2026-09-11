import 'package:flutter/material.dart';



import '../../../../core/constants/app_colors.dart';
import '../widgets/movie_header_widget.dart';
import '../widgets/screen_shots_widget.dart';
import '../widgets/similar_movies_widget.dart';
import '../widgets/cast_and_genres_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: ListView(
        physics: const BouncingScrollPhysics(),

        children: const [
          MovieHeaderWidget(),

          SizedBox(height: 20),

          ScreenShotsWidget(),

          SizedBox(height: 20),

          SimilarMoviesWidget(),

          SizedBox(height: 20),

          CastAndGenresWidget(),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}