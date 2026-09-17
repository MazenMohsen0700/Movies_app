class MovieEntity {
  final int id;
  final String title;
  final String imagePath;
  final String rating;
  final List<String> genres;

  MovieEntity({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.genres,
  });
}