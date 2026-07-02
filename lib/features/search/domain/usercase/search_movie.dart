import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';
import 'package:movie_discovery_app/features/dashboard/domain/repository/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;
  const SearchMovies(this.repository);
  Future<List<MovieEntity>> call(String query, {int page = 1}) =>
      repository.searchMovies(query, page: page);
}