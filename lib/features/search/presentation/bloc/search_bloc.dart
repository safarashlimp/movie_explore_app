import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/features/search/domain/usercase/search_movie.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/errors/failure.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  SearchBloc({required this.searchMovies}) : super(SearchInitial()) {
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 400))
          .distinct()
          .switchMap(mapper),
    );
    on<ClearSearch>((_, emit) => emit(SearchInitial()));
  }

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final q = event.query.trim();
    if (q.isEmpty) { emit(SearchInitial()); return; }

    emit(SearchLoading());
    try {
      final results = await searchMovies(q);
      emit(results.isEmpty ? SearchEmpty() : SearchLoaded(results, q));
    } on Failure catch (e) {
      emit(SearchError(e.message));
    } catch (_) {
      emit(SearchError('Search failed. Please try again.'));
    }
  }
}

