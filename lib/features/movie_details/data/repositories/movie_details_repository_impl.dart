import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/movie_details_entity.dart';
import '../../domain/entities/similar_movie_entity.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../models/movie_details_model.dart';
import '../models/similar_movie_model.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final RemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<MovieDetailsEntity> getMovieDetails(int movieId) async {
    final response = await remoteDataSource.getMovieDetails(movieId);

    final movieJson = response.data['data']['movie'];

    final model = MovieDetailsModel.fromJson(movieJson);

    return MovieDetailsEntity(
      id: model.id,
      title: model.title,
      titleLong: model.titleLong,
      year: model.year,
      rating: model.rating,
      runtime: model.runtime,
      likeCount: model.likeCount,
      description: model.description,
      backgroundImage: model.backgroundImage,
      posterImage: model.posterImage,
      screenshot1: model.screenshot1,
      screenshot2: model.screenshot2,
      screenshot3: model.screenshot3,
      genres: model.genres,
      cast: model.cast.map((cast) {
        return CastEntity(
          name: cast.name,
          characterName: cast.characterName,
          image: cast.image,
        );
      }).toList(),
    );
  }

  @override
  Future<List<SimilarMovieEntity>> getSimilarMovies(int movieId) async {
    final response =
    await remoteDataSource.getMovieSuggestions(movieId);

    final moviesJson = response.data['data']['movies'] as List;

    return moviesJson.map((movieJson) {
      final model = SimilarMovieModel.fromJson(movieJson);

      return SimilarMovieEntity(
        id: model.id,
        title: model.title,
        rating: model.rating,
        image: model.image,
      );
    }).toList();
  }
}