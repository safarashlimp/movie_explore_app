import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';
import 'package:movie_discovery_app/features/dashboard/domain/repository/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository repository;
  const GetTrendingMovies(this.repository);
  Future<List<MovieEntity>> call({int page = 1}) =>
      repository.getTrendingMovies(page: page);
}