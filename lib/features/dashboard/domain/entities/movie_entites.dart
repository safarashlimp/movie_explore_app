import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
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

  const MovieEntity({
    required this.id,
    required this.adult,
    this.title,
    this.name,
    this.originalTitle,
    this.originalName,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    this.releaseDate,
    this.firstAirDate,
    required this.genreIds,
    required this.video,
    required this.originalLanguage,
  });

  /// Returns the movie title for both Movies and TV Shows.
  String get movieTitle =>
      title ??
      name ??
      originalTitle ??
      originalName ??
      '';

  /// Returns the release date for both Movies and TV Shows.
  String get movieReleaseDate =>
      releaseDate ??
      firstAirDate ??
      '';

  /// Full poster URL
  String get posterUrl =>
      'https://image.tmdb.org/t/p/w500$posterPath';

  /// Full backdrop URL
  String get backdropUrl =>
      'https://image.tmdb.org/t/p/w780$backdropPath';

  /// Rating formatted to one decimal place.
  String get rating => voteAverage.toStringAsFixed(1);

  /// Release year.
  String get year =>
      movieReleaseDate.isNotEmpty
          ? movieReleaseDate.substring(0, 4)
          : '';

  @override
  List<Object?> get props => [
        id,
        adult,
        title,
        name,
        originalTitle,
        originalName,
        overview,
        posterPath,
        backdropPath,
        popularity,
        voteAverage,
        voteCount,
        releaseDate,
        firstAirDate,
        genreIds,
        video,
        originalLanguage,
      ];
}