import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/core/errors/failure.dart';
import 'package:movie_discovery_app/features/dashboard/domain/usercase/get_now_playing.dart';
import 'package:movie_discovery_app/features/dashboard/domain/usercase/get_popular_movie.dart';
import 'package:movie_discovery_app/features/dashboard/domain/usercase/get_top_rated.dart';
import 'package:movie_discovery_app/features/dashboard/domain/usercase/get_tranting_movie.dart';
import 'package:movie_discovery_app/features/dashboard/presentation/bloc/dash_board_event.dart';
import 'package:movie_discovery_app/features/dashboard/presentation/bloc/dash_board_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetTrendingMovies getTrending;
  final GetPopularMovies  getPopular;
  final GetNowPlaying     getNowPlaying;
  final GetTopRated       getTopRated;

  DashboardBloc({
    required this.getTrending,
    required this.getPopular,
    required this.getNowPlaying,
    required this.getTopRated,
  }) : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoad);
    on<RefreshDashboard>(_onRefresh);
  }

  Future<void> _onLoad(LoadDashboard event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    await _fetchAll(emit);
  }

  Future<void> _onRefresh(RefreshDashboard event, Emitter<DashboardState> emit) async {
    await _fetchAll(emit);
  }

  Future<void> _fetchAll(Emitter<DashboardState> emit) async {
    try {
      final results = await Future.wait([
        getTrending(),
        getPopular(),
        getNowPlaying(),
        getTopRated(),
      ]);
      emit(DashboardLoaded(
        trending   : results[0],
        popular    : results[1],
        nowPlaying : results[2],
        topRated   : results[3],
      ));
    } on Failure catch (e) {
      emit(DashboardError(e.message));
    } catch (_) {
      emit( DashboardError('Something went wrong. Please try again.'));
    }
  }
}