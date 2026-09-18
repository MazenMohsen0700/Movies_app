import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/cast_entity.dart';

class CastAndGenresWidget extends StatelessWidget {
  final String description;
  final List<CastEntity> cast;
  final List<String> genres;

  const CastAndGenresWidget({
    super.key,
    required this.description,
    required this.cast,
    required this.genres,
  });

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

          Text(
            description,
            style: const TextStyle(
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
            children: cast
                .map((castMember) => _buildCastCard(castMember))
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

  Widget _buildCastCard(CastEntity cast) {
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
            child: Image.network(
              cast.image,
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
                        text: cast.characterName,
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