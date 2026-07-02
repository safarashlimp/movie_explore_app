import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_discovery_app/core/theme/app_theme.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';

class DetailPage extends StatelessWidget {
  final MovieEntity movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.bgColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.backdropUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppTheme.cardColor),
                    errorWidget: (_, __, ___) => Container(color: AppTheme.cardColor),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppTheme.bgColor],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.movieTitle, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _Badge(movie.year, Colors.grey.shade700),
                      const SizedBox(width: 8),
                      _Badge('HD', AppTheme.accentColor.withOpacity(0.3)),
                      const SizedBox(width: 8),
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(movie.rating, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _ActionButton(icon: Icons.play_arrow_rounded, label: 'Play', primary: true),
                      const SizedBox(width: 12),
                      _ActionButton(icon: Icons.download_rounded, label: 'Download', primary: false),
                      const SizedBox(width: 12),
                      _ActionButton(icon: Icons.add_rounded, label: 'Watchlist', primary: false),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  const SizedBox(height: 10),
                  Text(movie.overview, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14, height: 1.6)),
                  const SizedBox(height: 24),
                  // Mock cast section
                  const Text('Cast', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: ['Actor 1', 'Actor 2', 'Actor 3', 'Actor 4', 'Actor 5']
                          .map((name) => Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                              children: [
                                CircleAvatar(radius: 30, backgroundColor: AppTheme.cardColor, child: const Icon(Icons.person_rounded, color: Colors.grey)),
                                const SizedBox(height: 6),
                                Text(name, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                              ],
                            ),
                          ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  const _Badge(this.text, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: const TextStyle(fontSize: 11, color: AppTheme.textPrimary)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool primary;
  const _ActionButton({required this.icon, required this.label, required this.primary});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: primary ? AppTheme.accentColor : AppTheme.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}