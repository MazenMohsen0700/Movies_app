class MovieModel {
  final int id;
  final String title;
  final String imagePath;
  final String rating;
  final List<String> genres;

  const MovieModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      imagePath: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toString(),
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}