class SimilarMovieModel {
  final int id;
  final String title;
  final double rating;
  final String image;

  SimilarMovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.image,
  });

  factory SimilarMovieModel.fromJson(Map<String, dynamic> json) {
    return SimilarMovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      image: json['medium_cover_image'] ?? '',
    );
  }
}