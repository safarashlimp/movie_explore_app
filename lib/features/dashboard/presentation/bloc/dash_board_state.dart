import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<MovieEntity> trending;
  final List<MovieEntity> popular;
  final List<MovieEntity> nowPlaying;
  final List<MovieEntity> topRated;

  DashboardLoaded({
    required this.trending,
    required this.popular,
    required this.nowPlaying,
    required this.topRated,
  });

  @override
  List<Object?> get props => [trending, popular, nowPlaying, topRated];
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
  @override
  List<Object?> get props => [message];
}
