import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/features/layout/presentation/manager/move_cubit.dart';
import 'package:movie_app/features/layout/presentation/screens/see_more_screen.dart';

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
  Widget build(BuildContext context) {
    return BlocBuilder<MoveCubit, MoveState>(
      buildWhen: (previous, current) {
        return previous.moveState != current.moveState;
      },
      builder: (context, state) {
        if (state.moveState is Success) {
          var successState = state.moveState as Success<List<MoveEntity>>;
          var data = successState.data;
          List<String> genres = [];
          for (var move in data ?? []) {
            for (var genre in move.genres ?? []) {
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
                          data?[selectedIndex].mediumCoverImage ?? "",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
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
                        child: Image.asset(AppImage.availableNow, width: 267.w),
                      ),
                      Positioned(
                        top: 120.h,
                        left: 0,
                        right: 0,

                        child: CarouselSlider.builder(
                          itemCount: data?.length ?? 0,
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
                          itemBuilder: (context, itemIndex, pageViewIndex) {
                            return InkWell(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Image.network(
                                    data?[itemIndex].mediumCoverImage ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    left: 9,
                                    top: 5,
                                    child: Container(
                                      padding: EdgeInsetsGeometry.all(5),
                                      width: 58.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.4,
                                        ),
                                        borderRadius:
                                            BorderRadiusGeometry.circular(10.r),
                                      ),
                                      child: Row(
                                        spacing: 5.w,
                                        children: [
                                          Text(
                                            "${data?[itemIndex].rating}",
                                            style: TextStyle(
                                              color: AppColors.white,
                                            ),
                                          ),
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
                        child: Image.asset(AppImage.watchNow, width: 300.w),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                genres[index],
                                style: AppTextStyle.font20WhiteRegular,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SeeMoreScreen(genre: genres[index]),
                                    ),
                                  );
                                },
                                child: Row(
                                  spacing: 5.w,
                                  children: [
                                    Text(
                                      "see more",
                                      style: AppTextStyle.seeMore,
                                    ),
                                    SvgPicture.asset(AppImage.icArrowRight),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 165.h,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 16.w),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, moveIndex) {
                                var moves = data
                                    .where(
                                      (move) =>
                                          move.genres?.contains(
                                            genres[index],
                                          ) ??
                                          false,
                                    )
                                    .toList();
                                return InkWell(
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        moves[moveIndex].mediumCoverImage ?? "",
                                        width: 150.w,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        left: 9,
                                        top: 5,
                                        child: Container(
                                          padding: EdgeInsetsGeometry.all(5),
                                          width: 58.w,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(
                                              alpha: 0.4,
                                            ),
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  10.r,
                                                ),
                                          ),
                                          child: Row(
                                            spacing: 5.w,
                                            children: [
                                              Text(
                                                "${data[index].rating}",
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                ),
                                              ),
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
                              itemCount: data!
                                  .where(
                                    (move) =>
                                        move.genres?.contains(genres[index]) ??
                                        false,
                                  )
                                  .length,
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      );
                    },
                    itemCount: genres.length,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          );
        } else if (state.moveState is Errorr) {
          var errorState = state.moveState as Errorr<List<MoveEntity>>;
          var data = errorState.error;
          return Text(
            data.toString(),
            style: TextStyle(color: Colors.red, fontSize: 16.sp),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.white),
          );
        }
      },
    );
  }
}
