import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';

abstract class ComingSoonState extends Equatable {
  @override List<Object?> get props => [];
}
class ComingSoonInitial extends ComingSoonState {}
class ComingSoonLoading extends ComingSoonState {}
class ComingSoonLoaded extends ComingSoonState {
  final List<MovieEntity> movies;
  final bool hasMore;
  final int  currentPage;
  ComingSoonLoaded({required this.movies, this.hasMore = true, this.currentPage = 1});
  @override List<Object?> get props => [movies, hasMore, currentPage];

  ComingSoonLoaded copyWith({
    List<MovieEntity>? movies,
    bool? hasMore,
    int? currentPage,
  }) => ComingSoonLoaded(
    movies: movies ?? this.movies,
    hasMore: hasMore ?? this.hasMore,
    currentPage: currentPage ?? this.currentPage,
  );
}
class ComingSoonError extends ComingSoonState {
  final String message;
  ComingSoonError(this.message);
  @override List<Object?> get props => [message];
}
