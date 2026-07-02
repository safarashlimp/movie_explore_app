import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/movie_entites.dart';

class HeroBanner extends StatelessWidget {
  final MovieEntity movie;

  const HeroBanner({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 425,
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// BACKDROP IMAGE
              CachedNetworkImage(
                imageUrl: movie.backdropUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppTheme.cardColor,
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppTheme.cardColor,
                  child: const Center(
                    child: Icon(
                      Icons.movie,
                      color: Colors.white54,
                      size: 70,
                    ),
                  ),
                ),
              ),

              /// DARK OVERLAY
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.25),
                      Colors.transparent,
                      Colors.black.withOpacity(.75),
                      Colors.black,
                    ],
                    stops: const [
                      0,
                      .45,
                      .75,
                      1,
                    ],
                  ),
                ),
              ),

              /// TOP MENU
              Positioned(
                top: 5,
                left: 3,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/logos_netflix-icon (2).png',
                        color: Colors.red,
                        width: 53,
                        height: 53,
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "TV Shows",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Movies",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "My List",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// MOVIE DETAILS
              Positioned(
                left: 60,
                right: 20,
                top: 380,
                child: Row(
                  children: [
                    Spacer(),
                    Image.asset(
                      'assets/images/Group 16.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "# ${movie.movieTitle}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SmallButton(
              icon: Icons.add,
              label: "My List",
              onTap: () {},
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Change this value
                ),
              ),
              onPressed: () {
                context.push(
                  '/detail',
                  extra: movie,
                );
              },
              icon: const Icon(Icons.play_arrow, size: 20),
              label: const Text(
                "Play",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            _SmallButton(
              icon: Icons.info_outline,
              label: "Info",
              onTap: () {
                context.push(
                  '/detail',
                  extra: movie,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _SmallButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SmallButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
