import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/features/dashboard/presentation/widgets/preview%20section.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../domain/entities/movie_entites.dart';
import '../bloc/dash_board_bloc.dart';
import '../bloc/dash_board_event.dart';
import '../bloc/dash_board_state.dart';
import '../widgets/hero_banner.dart';
import '../widgets/movie_rail.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  Future<void> _refresh() async {
    context.read<DashboardBloc>().add(RefreshDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading || state is DashboardInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is DashboardError) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<DashboardBloc>().add(
                        LoadDashboard(),
                      );
                },
              );
            }

            final data = state as DashboardLoaded;

            final MovieEntity featured = data.trending.first;

            return RefreshIndicator(
              color: Colors.red,
              onRefresh: _refresh,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  /// HERO
                  SliverToBoxAdapter(
                    child: HeroBanner(
                      movie: featured,
                    ),
                  ),

                  /// PREVIEW
                  SliverToBoxAdapter(
                    child: PreviewSection(
                      movies: data.trending.take(10).toList(),
                    ),
                  ),

                  /// POPULAR
                  SliverToBoxAdapter(
                    child: MovieRail(
                      title: "Popular on Movies",
                      movies: data.popular,
                    ),
                  ),

                  /// TRENDING
                  SliverToBoxAdapter(
                    child: MovieRail(
                      title: "Trending Now",
                      movies: data.trending,
                    ),
                  ),

                  /// NOW PLAYING
                  SliverToBoxAdapter(
                    child: MovieRail(
                      title: "Now Playing",
                      movies: data.nowPlaying,
                    ),
                  ),

                  /// TOP RATED
                  SliverToBoxAdapter(
                    child: MovieRail(
                      title: "Top Rated",
                      movies: data.topRated,
                    ),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 30),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
