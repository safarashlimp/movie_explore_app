import 'package:dio/dio.dart';
import 'package:movie_discovery_app/core/errors/exception.dart';
import 'package:movie_discovery_app/features/dashboard/data/model/movie_model.dart';
import 'package:movie_discovery_app/features/dashboard/data/model/movie_responce_model.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';



abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrendingMovies({int page});

  Future<List<MovieModel>> getPopularMovies({int page});

  Future<List<MovieModel>> getTopRatedMovies({int page});

  Future<List<MovieModel>> getUpcomingMovies({int page});

  Future<List<MovieModel>> getNowPlayingMovies({int page});

  Future<List<MovieModel>> searchMovies(
    String query, {
    int page,
  });
}

class MovieRemoteDataSourceImpl
    implements MovieRemoteDataSource {
  final DioClient dioClient;

  MovieRemoteDataSourceImpl({
    required this.dioClient,
  });

  Future<List<MovieModel>> _fetchMovies(
    String endpoint, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dioClient.dio.get(
        endpoint,
        queryParameters: query,
      );

      final movieResponse =
          MovieResponseModel.fromJson(response.data);

      return movieResponse.results;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      }

      throw ServerException(
        e.response?.data?['status_message'] ??
            'Something went wrong',
      );
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies({
    int page = 1,
  }) {
    return _fetchMovies(
      ApiConstants.trending,
      query: {
        'page': page,
      },
    );
  }

  @override
  Future<List<MovieModel>> getPopularMovies({
    int page = 1,
  }) {
    return _fetchMovies(
      ApiConstants.popular,
      query: {
        'page': page,
      },
    );
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies({
    int page = 1,
  }) {
    return _fetchMovies(
      ApiConstants.topRated,
      query: {
        'page': page,
      },
    );
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies({
    int page = 1,
  }) {
    return _fetchMovies(
      ApiConstants.upcoming,
      query: {
        'page': page,
      },
    );
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies({
    int page = 1,
  }) {
    return _fetchMovies(
      ApiConstants.nowPlaying,
      query: {
        'page': page,
      },
    );
  }

  @override
  Future<List<MovieModel>> searchMovies(
    String query, {
    int page = 1,
  }) {
    return _fetchMovies(
      ApiConstants.searchMovie,
      query: {
        'query': query,
        'page': page,
      },
    );
  }
}