import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';

class MovieModel {
  final int id;
  final bool adult;
  final String? title;
  final String? name;
  final String? originalTitle;
  final String? originalName;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final String? releaseDate;
  final String? firstAirDate;
  final List<int> genreIds;
  final bool video;
  final String originalLanguage;

  const MovieModel({
    this.id = 0,
    this.adult = false,
    this.title,
    this.name,
    this.originalTitle,
    this.originalName,
    this.overview = "",
    this.posterPath = "",
    this.backdropPath = "",
    this.popularity = 0.0,
    this.voteAverage = 0.0,
    this.voteCount = 0,
    this.releaseDate,
    this.firstAirDate,
    this.genreIds = const [],
    this.video = false,
    this.originalLanguage = "",
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      adult: json['adult'] ?? false,
      title: json['title'],
      name: json['name'],
      originalTitle: json['original_title'],
      originalName: json['original_name'],
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'],
      firstAirDate: json['first_air_date'],
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      video: json['video'] ?? false,
      originalLanguage: json['original_language'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adult': adult,
      'title': title,
      'name': name,
      'original_title': originalTitle,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'release_date': releaseDate,
      'first_air_date': firstAirDate,
      'genre_ids': genreIds,
      'video': video,
      'original_language': originalLanguage,
    };
  }

  MovieModel copyWith({
    int? id,
    bool? adult,
    String? title,
    String? name,
    String? originalTitle,
    String? originalName,
    String? overview,
    String? posterPath,
    String? backdropPath,
    double? popularity,
    double? voteAverage,
    int? voteCount,
    String? releaseDate,
    String? firstAirDate,
    List<int>? genreIds,
    bool? video,
    String? originalLanguage,
  }) {
    return MovieModel(
      id: id ?? this.id,
      adult: adult ?? this.adult,
      title: title ?? this.title,
      name: name ?? this.name,
      originalTitle: originalTitle ?? this.originalTitle,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      popularity: popularity ?? this.popularity,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      releaseDate: releaseDate ?? this.releaseDate,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      genreIds: genreIds ?? this.genreIds,
      video: video ?? this.video,
      originalLanguage: originalLanguage ?? this.originalLanguage,
    );
  }

  /// Common title
  String get movieTitle => title ?? name ?? originalTitle ?? originalName ?? '';

  /// Common release date
  String get movieReleaseDate => releaseDate ?? firstAirDate ?? '';

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $movieTitle)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension MovieModelMapper on MovieModel {
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      adult: adult,
      title: title,
      name: name,
      originalTitle: originalTitle,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: releaseDate,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
      video: video,
      originalLanguage: originalLanguage,
    );
  }
}
