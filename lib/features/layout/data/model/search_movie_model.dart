class SearchMovieModel {
  final int id;
  final String title;
  final String image;
  final double rating;

  SearchMovieModel({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
  });

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) {
    return SearchMovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}