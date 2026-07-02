import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_widget.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: AppTheme.textPrimary),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search movies, shows...',
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: AppTheme.textSecondary),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _controller,
                    builder: (_, val, __) => val.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                color: AppTheme.textSecondary),
                            onPressed: () {
                              _controller.clear();
                              context.read<SearchBloc>().add(ClearSearch());
                            },
                          )
                        : Icon(Icons.mic_rounded,
                            color: AppTheme.textSecondary),
                  ),
                ),
                onChanged: (q) =>
                    context.read<SearchBloc>().add(SearchQueryChanged(q)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Top Searches',
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) return _buildInitialHint();
                  if (state is SearchLoading)
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppTheme.accentColor));
                  if (state is SearchEmpty) return _buildEmpty();
                  if (state is SearchError)
                    return AppErrorWidget(
                      message: state.message,
                      onRetry: () => context.read<SearchBloc>().add(
                            SearchQueryChanged(_controller.text),
                          ),
                    );
                  if (state is SearchLoaded)
                    return _buildResults(state.results, context);
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialHint() => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_rounded, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text('Search for movies and TV shows',
                style: TextStyle(color: AppTheme.textSecondary)),
          ],
        ),
      );

  Widget _buildEmpty() => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.movie_filter_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text('No results found',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 16)),
            SizedBox(height: 6),
            Text('Try a different search term',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );

  Widget _buildResults(List<MovieEntity> movies, BuildContext context) {
    return ListView.builder(
      //padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: movies.length,
      itemBuilder: (_, i) {
        final m = movies[i];
        return GestureDetector(
          onTap: () => context.push('/detail', extra: m),
          child: Container(
            margin: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: m.posterUrl,
                    width: 146,
                    height: 90,
                    fit: BoxFit.fill,
                    placeholder: (_, __) => Container(
                        width: 146, height: 76, color: AppTheme.bgColor),
                    errorWidget: (_, __, ___) => Container(
                      width: 146,
                      height: 76,
                      color: AppTheme.bgColor,
                      child:
                          const Icon(Icons.movie_outlined, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.movieTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: AppTheme.textPrimary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.play_circle_outline,
                      color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
