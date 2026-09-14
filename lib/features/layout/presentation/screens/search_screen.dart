import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:move_app/core/assets/app_image.dart';
import 'package:move_app/features/layout/data/model/move_model.dart';

class SearchScreen extends StatefulWidget {
 const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<MoveModel> moviesSearch = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  searchMovies(value);
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: SvgPicture.asset(AppImage.icSearch),
                  ),
                ),
                hintText: "Search",
                suffixIcon: searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            searchController.clear();
                            moviesSearch = [];
                          });
                        },
                        child: Icon(Icons.close),
                      )
                    : null,
              ),
            ),
            SizedBox(height: 16.h),
            moviesSearch.isEmpty && searchController.text.isEmpty
                ? Expanded(child: Image.asset(AppImage.emptySearch))
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 8.h,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        return Image.asset(moviesSearch[index].image);
                      },
                      itemCount: moviesSearch.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void searchMovies(String query) {
    if (query.trim().isEmpty) {
      moviesSearch = [];
      return;
    } else if (MoveModel.moves.isNotEmpty) {
      moviesSearch = MoveModel.moves.where((move) {
        return move.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}
