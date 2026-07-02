import 'package:get_it/get_it.dart';
import 'package:movie_discovery_app/features/coming_soon/domain/usercases/get_upcoming_movies.dart';
import 'package:movie_discovery_app/features/dashboard/data/data_source/movie_data_source.dart';
import 'package:movie_discovery_app/features/dashboard/data/repository/movie_repository_impl.dart';
import 'package:movie_discovery_app/features/dashboard/domain/repository/movie_repository.dart';
import 'package:movie_discovery_app/features/dashboard/domain/usercase/get_now_playing.dart';
import 'package:movie_discovery_app/features/dashboard/domain/usercase/get_popular_movie.dart';
import 'package:movie_discovery_app/features/dashboard/domain/usercase/get_top_rated.dart';
import 'package:movie_discovery_app/features/dashboard/domain/usercase/get_tranting_movie.dart';
import 'package:movie_discovery_app/features/dashboard/presentation/bloc/dash_board_bloc.dart';
import 'package:movie_discovery_app/features/search/domain/usercase/search_movie.dart';
import 'core/network/dio_client.dart';
import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/coming_soon/presentation/bloc/coming_soon_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs
  sl.registerFactory(() => DashboardBloc(
        getTrending: sl(),
        getPopular: sl(),
        getNowPlaying: sl(),
        getTopRated: sl(),
      ));
  sl.registerFactory(() => SearchBloc(searchMovies: sl()));
  sl.registerFactory(() => ComingSoonBloc(getUpcoming: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetTrendingMovies(sl()));
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetNowPlaying(sl()));
  sl.registerLazySingleton(() => GetTopRated(sl()));
  sl.registerLazySingleton(() => SearchMovies(sl()));
  sl.registerLazySingleton(() => GetUpcomingMovies(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(dioClient: sl()),
  );

  // Core
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => sl<DioClient>().dio);
}
