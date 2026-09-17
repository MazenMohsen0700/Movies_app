import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/constants/app_colors.dart';
import 'package:movie_app/core/widgets/movie_card.dart';
import 'package:movie_app/features/layout/presentation/screens/home_screen.dart';
import 'package:movie_app/features/movie_details/presentation/screens/movie_details_screen.dart';

import '../../../layout/presentation/screens/search_screen.dart';
import '../../../profile/presention/screens/profile_screen.dart';

import '../../data/data_sources/remote_data_source.dart';
import '../../data/repositories/browse_movies_repository_impl.dart';
import '../../domain/usecases/get_movies_by_genre_usecase.dart';
import '../bloc/browse_movies_bloc.dart';
import '../bloc/browse_movies_event.dart';
import '../bloc/browse_movies_state.dart';

class BrowseMoviesScreen extends StatefulWidget {
  const BrowseMoviesScreen({super.key});

  @override
  State<BrowseMoviesScreen> createState() => _BrowseMoviesScreenState();
}

class _BrowseMoviesScreenState extends State<BrowseMoviesScreen> {
  int selectedNavIndex = 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final remoteDataSource = RemoteDataSource();

        final repository = BrowseMoviesRepositoryImpl(
          remoteDataSource,
        );

        final useCase = GetMoviesByGenreUseCase(
          repository,
        );

        return BrowseMoviesBloc(useCase)
          ..add(GetGenresEvent());
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(
          index: selectedNavIndex,
          children: [
            HomeScreen(),
            const SearchScreen(),
            _buildBrowseContent(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BottomNavigationBar(
              currentIndex: selectedNavIndex,
              onTap: (index) {
                setState(() {
                  selectedNavIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: AppColors.yellow,
              unselectedItemColor: Colors.white,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    size: 28,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 28,
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.folder_copy_rounded,
                    size: 26,
                  ),
                  label: 'Browse',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                    size: 28,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrowseContent() {
    return SafeArea(
      child: BlocBuilder<BrowseMoviesBloc, BrowseMoviesState>(
        builder: (context, state) {
          if (state is BrowseMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is BrowseMoviesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is BrowseMoviesSuccess) {
            final categories = state.genres.toList();
            final movies = state.movies;

            return Column(
              children: [
                const SizedBox(height: 12),

                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount: categories.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemBuilder: (context, index) {
                      final isSelected =
                          state.selectedGenre == categories[index];

                      return GestureDetector(
                        onTap: () {
                          context.read<BrowseMoviesBloc>().add(
                            GetMoviesByGenreEvent(
                              categories[index],
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.yellow
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.yellow,
                              width: 1.8,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : AppColors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: movies.isEmpty
                      ? const Center(
                    child: Text(
                      'No movies found',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                      : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: movies.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsScreen(
                                    movieId: movie.id,
                                  ),
                            ),
                          );
                        },
                        child: MovieCard(
                          imagePath: movie.imagePath,
                          rating: movie.rating,
                          isNetworkImage: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}