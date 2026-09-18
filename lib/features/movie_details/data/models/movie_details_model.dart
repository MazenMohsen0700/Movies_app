import 'cast_model.dart';
import 'torrent_model.dart';

class MovieDetailsModel {
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
  final List<CastModel> cast;
  final List<TorrentModel> torrents;

  MovieDetailsModel({
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
    required this.torrents,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleLong: json['title_long'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      description: json['description_full'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      posterImage: json['large_cover_image'] ?? '',

      screenshot1: json['large_screenshot_image1'] ?? '',
      screenshot2: json['large_screenshot_image2'] ?? '',
      screenshot3: json['large_screenshot_image3'] ?? '',

      genres: List<String>.from(json['genres'] ?? []),

      cast: (json['cast'] as List<dynamic>?)
          ?.map((item) => CastModel.fromJson(item))
          .toList() ??
          [],

      torrents: (json['torrents'] as List<dynamic>?)
          ?.map((item) => TorrentModel.fromJson(item))
          .toList() ??
          [],
    );
  }
}