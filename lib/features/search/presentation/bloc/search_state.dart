import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';

abstract class SearchState extends Equatable {
  @override List<Object?> get props => [];
}
class SearchInitial  extends SearchState {}
class SearchLoading  extends SearchState {}
class SearchEmpty    extends SearchState {}
class SearchLoaded extends SearchState {
  final List<MovieEntity> results;
  final String query;
  SearchLoaded(this.results, this.query);
  @override List<Object?> get props => [results, query];
}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
  @override List<Object?> get props => [message];
}
