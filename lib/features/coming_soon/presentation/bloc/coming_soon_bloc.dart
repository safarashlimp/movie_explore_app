
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/features/coming_soon/domain/usercases/get_upcoming_movies.dart';
import 'package:movie_discovery_app/features/coming_soon/presentation/bloc/coming_soon_event.dart';
import 'package:movie_discovery_app/features/coming_soon/presentation/bloc/coming_soon_state.dart';
import '../../../../core/errors/failure.dart';

class ComingSoonBloc extends Bloc<ComingSoonEvent, ComingSoonState> {
  final GetUpcomingMovies getUpcoming;

  ComingSoonBloc({required this.getUpcoming}) : super(ComingSoonInitial()) {
    on<LoadUpcoming>(_onLoad);
    on<RefreshUpcoming>(_onRefresh);
    on<LoadMoreUpcoming>(_onLoadMore);
  }

  Future<void> _onLoad(LoadUpcoming _, Emitter<ComingSoonState> emit) async {
    emit(ComingSoonLoading());
    try {
      final movies = await getUpcoming(page: 1);
      emit(ComingSoonLoaded(movies: movies, currentPage: 1));
    } on Failure catch (e) {
      emit(ComingSoonError(e.message));
    } catch (_) {
      emit(ComingSoonError('Failed to load upcoming movies.'));
    }
  }

  Future<void> _onRefresh(RefreshUpcoming _, Emitter<ComingSoonState> emit) async {
    try {
      final movies = await getUpcoming(page: 1);
      emit(ComingSoonLoaded(movies: movies, currentPage: 1));
    } on Failure catch (e) {
      emit(ComingSoonError(e.message));
    }
  }

  Future<void> _onLoadMore(LoadMoreUpcoming event, Emitter<ComingSoonState> emit) async {
    final current = state;
    if (current is! ComingSoonLoaded) return;
    try {
      final more = await getUpcoming(page: event.page);
      if (more.isEmpty) {
        emit(current.copyWith(hasMore: false));
        return;
      }
      emit(current.copyWith(
        movies: [...current.movies, ...more],
        currentPage: event.page,
      ));
    } catch (_) {}
  }
}