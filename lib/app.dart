import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/icons/bxs.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:movie_discovery_app/features/dashboard/domain/entities/movie_entites.dart';
import 'package:movie_discovery_app/features/dashboard/presentation/bloc/dash_board_bloc.dart';
import 'package:movie_discovery_app/features/dashboard/presentation/pages/dash_board_screen.dart';
import 'package:movie_discovery_app/features/download/presentation/pages/download_page.dart';
import 'package:movie_discovery_app/features/profile/presentation/pages/profile_page.dart';
import 'package:movie_discovery_app/features/splash/presentation/pages/splash.dart';
import 'package:movie_discovery_app/features/user_name/presentation/pages/user_name.dart';
import 'core/theme/app_theme.dart';
import 'features/search/presentation/pages/search_page.dart';
import 'features/coming_soon/presentation/pages/coming_soon_page.dart';
import 'features/detail/presentation/pages/detail_page.dart';
import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/coming_soon/presentation/bloc/coming_soon_bloc.dart';
import 'injection_container.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<DashboardBloc>()),
        BlocProvider(create: (_) => sl<SearchBloc>()),
        BlocProvider(create: (_) => sl<ComingSoonBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Movie Discovery',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
    GoRoute(
      path: '/usernamepage',
      builder: (context, state) => const UserNamePage(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const DashboardPage()),
        GoRoute(path: '/search', builder: (_, __) => const SearchPage()),
        GoRoute(path: '/soon', builder: (_, __) => const ComingSoonPage()),
        GoRoute(path: '/downloads', builder: (_, __) => const DownloadPage()),
        GoRoute(path: '/profile', builder: (_, __) => const MorePage()),
      ],
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final movie = state.extra as MovieEntity;
        return DetailPage(movie: movie);
      },
    ),
  ],
);

class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _idx = 0;

  static const _tabs = ['/home', '/search', '/soon', '/downloads', '/profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) {
          setState(() => _idx = i);
          context.go(_tabs[i]);
        },
        backgroundColor: AppTheme.cardColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.textPrimary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Iconify(
              Mdi.home_outline,
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: Iconify(
              Mdi.home_outline,
              color: Colors.white,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: 'Search'),
          BottomNavigationBarItem(
              icon: Iconify(
                Bxs.videos,
                color: Colors.grey,
                size: 24,
              ),
              activeIcon: Iconify(
                Bxs.videos,
                color: Colors.white,
                size: 24,
              ),
              label: 'Coming'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_sharp), label: 'Downloads'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded), label: 'More'),
        ],
      ),
    );
  }
}
