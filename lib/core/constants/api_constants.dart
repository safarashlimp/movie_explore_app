class ApiConstants {
  ApiConstants._();
  // Pass API key via --dart-define=TMDB_API_KEY=your_key
  static const apiKey =
      '187057e86e84fc6efa51218df3307e34';
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const backdropBaseUrl = 'https://image.tmdb.org/t/p/w780';

  // Endpoints
  static const trending     = '/trending/all/week';
  static const popular      = '/movie/popular';
  static const nowPlaying   = '/movie/now_playing';
  static const topRated     = '/movie/top_rated';
  static const upcoming     = '/movie/upcoming';
  static const searchMovie  = '/search/movie';
}