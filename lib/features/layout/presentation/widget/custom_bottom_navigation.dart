import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_image.dart';
import '../../../../core/theme/app_color.dart';

class CustomBottomNavigation extends StatefulWidget {
  int selectedIndex;
  void Function(int index) onPressed;
  CustomBottomNavigation({
    super.key,
    this.selectedIndex = 0,
    required this.onPressed,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 61.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.navBarBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                AppImage.icHome,
                colorFilter: ColorFilter.mode(
                  widget.selectedIndex == 0
                      ? AppColors.navBarSelected
                      : AppColors.navBarUnselected,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                widget.onPressed(0);
                setState(() {});
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                AppImage.icSearch,
                colorFilter: ColorFilter.mode(
                  widget.selectedIndex == 1
                      ? AppColors.navBarSelected
                      : AppColors.navBarUnselected,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                widget.onPressed(1);
                setState(() {});
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                AppImage.icExplore,
                colorFilter: ColorFilter.mode(
                  widget.selectedIndex == 2
                      ? AppColors.navBarSelected
                      : AppColors.navBarUnselected,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                widget.onPressed(2);
                setState(() {});
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                AppImage.icProfile,
                colorFilter: ColorFilter.mode(
                  widget.selectedIndex == 3
                      ? AppColors.navBarSelected
                      : AppColors.navBarUnselected,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                widget.onPressed(3);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
