import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';

class ScreenShotsWidget extends StatelessWidget {
  final String screenshot1;
  final String screenshot2;
  final String screenshot3;

  const ScreenShotsWidget({
    super.key,
    required this.screenshot1,
    required this.screenshot2,
    required this.screenshot3,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> screenshots = [
      screenshot1,
      screenshot2,
      screenshot3,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          const Text(
            AppStrings.screenShots,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...screenshots.map((imagePath) {
            return Container(
              width: double.infinity,
              height: 170,
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}