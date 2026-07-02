import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/movie_entites.dart';

class PreviewSection extends StatelessWidget {
  final List<MovieEntity> movies;

  const PreviewSection({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Previews",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 140,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 18),
              itemBuilder: (_, index) {
                final movie = movies[index];

                return GestureDetector(
                  onTap: () {
                    context.push(
                      '/detail',
                      extra: movie,
                    );
                  },
                  child: SizedBox(
                    width: 90,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 51,
                            backgroundColor: AppTheme.cardColor,
                            backgroundImage: movie.posterPath.isNotEmpty
                                ? NetworkImage(
                                    movie.posterUrl,
                                  )
                                : null,
                            child: movie.posterPath.isEmpty
                                ? const Icon(
                                    Icons.movie,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.movieTitle,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
