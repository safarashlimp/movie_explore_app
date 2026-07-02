import 'dates_model.dart';
import 'movie_model.dart';

class MovieResponseModel {
  final DatesModel? dates;
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  const MovieResponseModel({
    this.dates,
    this.page = 1,
    this.results = const [],
    this.totalPages = 1,
    this.totalResults = 0,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      dates: json['dates'] != null
          ? DatesModel.fromJson(json['dates'] as Map<String, dynamic>)
          : null,
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 1,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  MovieResponseModel copyWith({
    DatesModel? dates,
    int? page,
    List<MovieModel>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return MovieResponseModel(
      dates: dates ?? this.dates,
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  @override
  String toString() {
    return 'MovieResponseModel(page: $page, results: ${results.length})';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieResponseModel &&
          page == other.page &&
          totalPages == other.totalPages &&
          totalResults == other.totalResults;

  @override
  int get hashCode =>
      page.hashCode ^
      totalPages.hashCode ^
      totalResults.hashCode;
}