import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:move_app/core/assets/app_image.dart';
import 'package:move_app/core/theme/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> posterList = [
    AppImage.poster1917,
    AppImage.poster1917,
    AppImage.posterCaptainAmerica,
    AppImage.posterCaptainAmerica,
    AppImage.posterBlackWidow,
    AppImage.posterBlackWidow,
    AppImage.posterIronMan3,
    AppImage.posterIronMan3,
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                posterList[selectedIndex],
                width: double.infinity,
                fit: BoxFit.cover,
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
                  itemCount: posterList.length,
                  options: CarouselOptions(
                    height: 300.h,
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
                    return Image.asset(
                      posterList[itemIndex],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 35,
                child: Image.asset(AppImage.watchNow, width: 354.w),
              ),
            ],
          ),

          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Action", style: AppTextStyle.font20WhiteRegular),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    spacing: 5.w,
                    children: [
                      Text("see more", style: AppTextStyle.seeMore),
                      SvgPicture.asset(AppImage.icArrowRight),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 250.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    posterList[index],
                    fit: BoxFit.cover,
                    width: 146.w,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 16.w),
              itemCount: posterList.length,
            ),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Action", style: AppTextStyle.font20WhiteRegular),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    spacing: 5.w,
                    children: [
                      Text("see more", style: AppTextStyle.seeMore),
                      SvgPicture.asset(AppImage.icArrowRight),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 250.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    posterList[index],
                    fit: BoxFit.cover,
                    width: 146.w,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 16.w),
              itemCount: posterList.length,
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
