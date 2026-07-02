import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/date_entity.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';


class MovieResponseEntity extends Equatable {
  final DatesEntity? dates;
  final int page;
  final List<MovieEntity> results;
  final int totalPages;
  final int totalResults;

  const MovieResponseEntity({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  @override
  List<Object?> get props => [
        dates,
        page,
        results,
        totalPages,
        totalResults,
      ];
}