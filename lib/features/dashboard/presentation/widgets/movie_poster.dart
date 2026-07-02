import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/movie_entites.dart';

class MoviePoster extends StatelessWidget {
  final MovieEntity movie;
  final double width;
  final double height;
  final bool showTitle;
  final bool showRating;

  const MoviePoster({
    super.key,
    required this.movie,
    this.width = 103,
    this.height = 160,
    this.showTitle = false,
    this.showRating = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/detail',
          extra: movie,
        );
      },
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'movie_${movie.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: movie.posterUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: AppTheme.cardColor,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: AppTheme.cardColor,
                    child: const Center(
                      child: Icon(
                        Icons.movie,
                        size: 50,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (showTitle) ...[
              const SizedBox(height: 8),
              Text(
                movie.movieTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (showRating) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    movie.rating,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
