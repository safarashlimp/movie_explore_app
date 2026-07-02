import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_discovery_app/features/coming_soon/presentation/widgets/notification_sector.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../features/dashboard/domain/entities/movie_entites.dart';
import '../../../../features/dashboard/presentation/widgets/shimmer_rail.dart';
import '../bloc/coming_soon_bloc.dart';
import '../bloc/coming_soon_event.dart';
import '../bloc/coming_soon_state.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({super.key});

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<ComingSoonBloc>().add(LoadUpcoming());

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<ComingSoonBloc>().state;

    if (state is! ComingSoonLoaded) return;

    if (!state.hasMore) return;

    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 300) {
      context
          .read<ComingSoonBloc>()
          .add(LoadMoreUpcoming(state.currentPage + 1));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const NotificationSection(),
            Expanded(
              child: BlocBuilder<ComingSoonBloc, ComingSoonState>(
                builder: (context, state) {
                  if (state is ComingSoonLoading ||
                      state is ComingSoonInitial) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (_, __) => const Padding(
                        padding: EdgeInsets.all(16),
                        child: ShimmerCard(
                          width: double.infinity,
                          height: 320,
                        ),
                      ),
                    );
                  }

                  if (state is ComingSoonError) {
                    return AppErrorWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<ComingSoonBloc>().add(
                              LoadUpcoming(),
                            );
                      },
                    );
                  }

                  if (state is ComingSoonLoaded) {
                    return RefreshIndicator(
                      color: AppTheme.accentColor,
                      onRefresh: () async {
                        context.read<ComingSoonBloc>().add(
                              RefreshUpcoming(),
                            );
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        itemCount:
                            state.movies.length + (state.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.movies.length) {
                            return const Padding(
                              padding: EdgeInsets.all(24),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          return UpcomingMovieCard(
                            movie: state.movies[index],
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UpcomingMovieCard extends StatelessWidget {
  final MovieEntity movie;

  const UpcomingMovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    String release = "Coming Soon";

    if (movie.movieReleaseDate.isNotEmpty) {
      release =
          DateFormat("MMMM dd").format(DateTime.parse(movie.movieReleaseDate));
    }

    return InkWell(
      onTap: () {
        context.push(
          "/detail",
          extra: movie,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// BACKDROP
            CachedNetworkImage(
              imageUrl: movie.backdropUrl,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: Colors.grey.shade900,
                height: 220,
              ),
              errorWidget: (_, __, ___) => Container(
                height: 220,
                color: Colors.grey.shade900,
                child: const Icon(
                  Icons.movie,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Column(
                    children: const [
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Remind Me",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 22),
                  Column(
                    children: const [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Share",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Coming $release",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                movie.movieTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                movie.overview,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    "Action",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "•",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Adventure",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "•",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Drama",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "•",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Thriller",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
