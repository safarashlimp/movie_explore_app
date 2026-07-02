import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';
import 'package:movie_discovery_app/features/dashboard/domain/repository/movie_repository.dart';

class GetUpcomingMovies {
  final MovieRepository repository;
  const GetUpcomingMovies(this.repository);
  Future<List<MovieEntity>> call({int page = 1}) =>
      repository.getUpcomingMovies(page: page);
}