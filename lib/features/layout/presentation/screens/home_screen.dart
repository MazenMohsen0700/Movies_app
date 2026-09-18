import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/features/layout/presentation/manager/move_cubit.dart';
import 'package:movie_app/features/layout/presentation/screens/see_more_screen.dart';
import 'package:movie_app/features/movie_details/presentation/screens/movie_details_screen.dart';

import '../../../../core/assets/app_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/states/base_state.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entity/move_entity.dart';
import '../manager/move_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoveCubit>().getMove('all');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoveCubit, MoveState>(
      buildWhen: (previous, current) {
        return previous.moveState != current.moveState;
      },
      builder: (context, state) {
        if (state.moveState is Success) {
          final successState =
          state.moveState as Success<List<MoveEntity>>;

          final data = successState.data ?? [];

          if (data.isEmpty) {
            return Center(
              child: Text(
                'No movies found',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
              ),
            );
          }

          if (selectedIndex >= data.length) {
            selectedIndex = 0;
          }

          final List<String> genres = [];

          for (final move in data) {
            for (final genre in move.genres ?? []) {
              if (!genres.contains(genre)) {
                genres.add(genre);
              }
            }
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 450.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          data[selectedIndex].mediumCoverImage ?? '',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xCC121312),
                                Color(0x99121312),
                                Color(0xFF121312),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 7,
                        child: Image.asset(
                          AppImage.availableNow,
                          width: 267.w,
                        ),
                      ),
                      Positioned(
                        top: 120.h,
                        left: 0,
                        right: 0,
                        child: CarouselSlider.builder(
                          itemCount: data.length,
                          options: CarouselOptions(
                            height: 250.h,
                            viewportFraction: 0.5,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            onPageChanged: (index, reason) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                          itemBuilder:
                              (context, itemIndex, pageViewIndex) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetailsScreen(
                                          movieId: data[itemIndex].id?.toInt() ?? 0,
                                        ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Image.network(
                                    data[itemIndex].mediumCoverImage ??
                                        '',
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    left: 9,
                                    top: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 58.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.4,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(10.r),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${data[itemIndex].rating}',
                                            style: TextStyle(
                                              color: AppColors.white,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Image.asset(
                                            AppImage.starIcn,
                                            width: 15.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: -35,
                        child: Image.asset(
                          AppImage.watchNow,
                          width: 300.w,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      final genreMovies = data
                          .where(
                            (move) =>
                        move.genres?.contains(genres[index]) ??
                            false,
                      )
                          .toList();

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                genres[index],
                                style:
                                AppTextStyle.font20WhiteRegular,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SeeMoreScreen(
                                            genre: genres[index],
                                          ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'see more',
                                      style: AppTextStyle.seeMore,
                                    ),
                                    SizedBox(width: 5.w),
                                    SvgPicture.asset(
                                      AppImage.icArrowRight,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 165.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: genreMovies.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 16.w);
                              },
                              itemBuilder: (context, moveIndex) {
                                final movie =
                                genreMovies[moveIndex];

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(
                                              movieId: movie.id?.toInt() ?? 0,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        movie.mediumCoverImage ?? '',
                                        width: 150.w,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        left: 9,
                                        top: 5,
                                        child: Container(
                                          padding:
                                          const EdgeInsets.all(5),
                                          width: 58.w,
                                          decoration: BoxDecoration(
                                            color:
                                            Colors.black.withValues(
                                              alpha: 0.4,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${movie.rating}',
                                                style: TextStyle(
                                                  color:
                                                  AppColors.white,
                                                ),
                                              ),
                                              SizedBox(width: 5.w),
                                              Image.asset(
                                                AppImage.starIcn,
                                                width: 15.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          );
        }

        if (state.moveState is Errorr) {
          final errorState =
          state.moveState as Errorr<List<MoveEntity>>;

          return Center(
            child: Text(
              errorState.error.toString(),
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        );
      },
    );
  }
}