import 'package:flutter/material.dart';


import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class MovieHeaderWidget extends StatefulWidget {
  final String title;
  final String year;
  final String imagePath;
  final String rating;
  final int likesCount;
  final String duration;

  const MovieHeaderWidget({
    super.key,
    this.title = 'Doctor Strange in the Multiverse\nof Madness',
    this.year = '2022',
    this.imagePath = AppAssets.doctorStrange,
    this.rating = '7.6',
    this.likesCount = 15,
    this.duration = '90',
  });

  @override
  State<MovieHeaderWidget> createState() => _MovieHeaderWidgetState();
}

class _MovieHeaderWidgetState extends State<MovieHeaderWidget> {
  bool isSaved = false;
  bool isLiked = false;
  late int currentLikes;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.likesCount;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topPadding = MediaQuery.of(context).padding.top;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.72,
          width: screenWidth,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.card,
                      child: const Icon(
                        Icons.movie_outlined,
                        color: Colors.white24,
                        size: 80,
                      ),
                    );
                  },
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.transparent,
                        AppColors.background.withOpacity(0.95),
                      ],
                      stops: const [0.0, 0.25, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: topPadding + 6,
                left: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: topPadding + 6,
                right: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isSaved = !isSaved;
                      });
                    },
                    icon: Icon(
                      isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: isSaved
                          ? AppColors.yellow
                          : Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: Align(
                  alignment: const Alignment(0, -0.1),
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      AppAssets.watch,
                      width: 85,
                      height: 85,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 75,
                          height: 75,
                          decoration: const BoxDecoration(
                            color: AppColors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 20,
                right: 20,
                bottom: 12,
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.year,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                AppStrings.watch,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: MovieStatWidget(
                  icon: isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  iconColor: isLiked
                      ? AppColors.red
                      : AppColors.yellow,
                  text: '$currentLikes',
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;

                      if (isLiked) {
                        currentLikes++;
                      } else {
                        currentLikes--;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MovieStatWidget(
                  icon: Icons.access_time_rounded,
                  iconColor: AppColors.yellow,
                  text: widget.duration,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MovieStatWidget(
                  icon: Icons.star_rounded,
                  iconColor: AppColors.yellow,
                  text: widget.rating,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MovieStatWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final VoidCallback? onTap;

  const MovieStatWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
