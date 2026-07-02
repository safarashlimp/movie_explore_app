import 'package:movie_discovery_app/core/errors/exception.dart';
import 'package:movie_discovery_app/core/errors/failure.dart';

import 'package:movie_discovery_app/features/dashboard/data/data_source/movie_data_source.dart';
import 'package:movie_discovery_app/features/dashboard/data/model/movie_model.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';

import 'package:movie_discovery_app/features/dashboard/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
  });

  Future<List<MovieEntity>> _safeCall(
    Future<List<MovieModel>> Function() call,
  ) async {
    try {
      final models = await call();

      return models.map((movie) => movie.toEntity()).toList();
    } on NetworkException {
      throw const NetworkFailure();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }

  @override
  Future<List<MovieEntity>> getTrendingMovies({int page = 1}) {
    return _safeCall(
      () => remoteDataSource.getTrendingMovies(page: page),
    );
  }

  @override
  Future<List<MovieEntity>> getPopularMovies({int page = 1}) {
    return _safeCall(
      () => remoteDataSource.getPopularMovies(page: page),
    );
  }

  @override
  Future<List<MovieEntity>> getNowPlayingMovies({int page = 1}) {
    return _safeCall(
      () => remoteDataSource.getNowPlayingMovies(page: page),
    );
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies({int page = 1}) {
    return _safeCall(
      () => remoteDataSource.getTopRatedMovies(page: page),
    );
  }

  @override
  Future<List<MovieEntity>> getUpcomingMovies({int page = 1}) {
    return _safeCall(
      () => remoteDataSource.getUpcomingMovies(page: page),
    );
  }

  @override
  Future<List<MovieEntity>> searchMovies(
    String query, {
    int page = 1,
  }) {
    return _safeCall(
      () => remoteDataSource.searchMovies(query, page: page),
    );
  }
}
