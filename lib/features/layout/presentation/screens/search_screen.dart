import '../../../movie_details/presentation/screens/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_image.dart';
import '../../data/data_sources/search_remote_data_source.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/usecases/search_movies_usecase.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = SearchRemoteDataSource();

    final repository = SearchRepositoryImpl(
      remoteDataSource,
    );

    final useCase = SearchMoviesUseCase(
      repository,
    );

    return BlocProvider(
      create: (_) => SearchBloc(useCase),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) {
                context.read<SearchBloc>().add(
                  SearchMoviesEvent(value),
                );

                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: SvgPicture.asset(
                      AppImage.icSearch,
                    ),
                  ),
                ),
                hintText: "Search",
                hintStyle: const TextStyle(
                  color: Colors.white30,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? GestureDetector(
                  onTap: () {
                    searchController.clear();

                    context.read<SearchBloc>().add(
                      SearchMoviesEvent(''),
                    );

                    setState(() {});
                  },
                  child: const Icon(Icons.close),
                )
                    : null,
              ),
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Image.asset(
                      AppImage.emptySearch,
                    );
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  if (state is SearchSuccess) {
                    if (state.movies.isEmpty) {
                      return const Center(
                        child: Text(
                          'No movies found',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 8.h,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              movie.image,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return const Icon(
                                  Icons.movie,
                                  color: Colors.white54,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
