import 'cast_entity.dart';

class MovieDetailsEntity {
  final int id;
  final String title;
  final String titleLong;
  final int year;
  final double rating;
  final int runtime;
  final int likeCount;
  final String description;
  final String backgroundImage;
  final String posterImage;
  final String screenshot1;
  final String screenshot2;
  final String screenshot3;
  final List<String> genres;
  final List<CastEntity> cast;

  MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.likeCount,
    required this.description,
    required this.backgroundImage,
    required this.posterImage,
    required this.screenshot1,
    required this.screenshot2,
    required this.screenshot3,
    required this.genres,
    required this.cast,
  });
}