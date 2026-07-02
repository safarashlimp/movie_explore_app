

import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getTrendingMovies({int page = 1});

  Future<List<MovieEntity>> getPopularMovies({int page = 1});

  Future<List<MovieEntity>> getNowPlayingMovies({int page = 1});

  Future<List<MovieEntity>> getTopRatedMovies({int page = 1});

  Future<List<MovieEntity>> getUpcomingMovies({int page = 1});

  Future<List<MovieEntity>> searchMovies(
    String query, {
    int page = 1,
  });
}