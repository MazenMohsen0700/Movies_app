import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/assets/app_image.dart';
import 'package:movie_app/core/conging/confing.dart';
import 'package:movie_app/core/constants/app_colors.dart';
import 'package:movie_app/core/states/base_state.dart';
import 'package:movie_app/core/theme/app_text_style.dart';
import 'package:movie_app/features/layout/presentation/manager/move_cubit.dart';

import '../../domain/entity/move_entity.dart';
import '../manager/move_state.dart';

class SeeMoreScreen extends StatelessWidget {
  final String genre;
  const SeeMoreScreen({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MoveCubit>()..getMove(genre),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          foregroundColor: AppColors.white,
          elevation: 0,
          title: Text(genre),
        ),
        body: BlocBuilder<MoveCubit, MoveState>(
          buildWhen: (previous, current) {
            return previous.moveState != current.moveState;
          },
          builder: (context, state) {
            if (state.moveState is Success) {
              var successState = state.moveState as Success<List<MoveEntity>>;
              var data = successState.data;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(22.r),
                                child: Image.network(
                                  data?[index].mediumCoverImage ?? "",
                                  width: 250.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 9,
                              top: 5,
                              child: Container(
                                padding: EdgeInsetsGeometry.all(5),
                                width: 58.w,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.4), borderRadius: BorderRadiusGeometry.circular(10.r)
                                ),
                                child: Row(
                                  spacing: 5.w,
                                  children: [
                                    Text(
                                      "${data?[index].rating}",
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                    Image.asset(AppImage.starIcn, width: 15.w),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        Text(
                          data?[index].title ?? "",
                          style: AppTextStyle.bodyLarge,maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                  itemCount: data?.length ?? 0,
                ),
              );
            } else if (state.moveState is Errorr) {
              var errorState = state.moveState as Errorr<List<MoveEntity>>;
              var data = errorState.error;
              return Text(
                data.toString(),
                style: TextStyle(color: AppColors.red, fontSize: 16.sp),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: AppColors.white),
              );
            }
          },
        ),
      ),
    );
  }
}
