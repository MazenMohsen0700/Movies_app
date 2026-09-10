import 'package:flutter/material.dart';

import 'package:movie_app/core/constants/app_colors.dart';
import 'package:movie_app/core/constants/app_strings.dart';

class CastModel {
  final String name;
  final String character;
  final String imagePath;

  const CastModel({
    required this.name,
    required this.character,
    required this.imagePath,
  });
}

class CastAndGenresWidget extends StatelessWidget {
  const CastAndGenresWidget({Key? key}) : super(key: key);

  final List<CastModel> castList = const [
    CastModel(
      name: 'Hayley Atwell',
      character: 'Captain Carter',
      imagePath: 'assets/cost/Hayley.png',
    ),
    CastModel(
      name: 'Elizabeth Olsen',
      character: 'Wanda Maximoff / The Scarlet Witch',
      imagePath: 'assets/cost/Elizabeth.png',
    ),
    CastModel(
      name: 'Rachel McAdams',
      character: 'Dr. Christine Palmer',
      imagePath: 'assets/cost/Rachel.png',
    ),
    CastModel(
      name: 'Charlize Theron',
      character: 'Clea',
      imagePath: 'assets/cost/Charlize.png',
    ),
  ];

  final List<String> genres = const [
    'Action',
    'Sci-Fi',
    'Adventure',
    'Fantasy',
    'Horror',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          const Text(
            AppStrings.summary,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            AppStrings.cast,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Column(
            children: castList
                .map((cast) => _buildCastCard(cast))
                .toList(),
          ),

          const SizedBox(height: 24),

          const Text(
            AppStrings.genres,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: genres
                .map((genre) => _buildGenreChip(genre))
                .toList(),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCastCard(CastModel cast) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              cast.imagePath,
              width: 55,
              height: 55,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 55,
                  height: 55,
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white54,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    children: [
                      const TextSpan(
                        text: AppStrings.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                      TextSpan(
                        text: cast.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    children: [
                      const TextSpan(
                        text: AppStrings.character,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                      TextSpan(
                        text: cast.character,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}