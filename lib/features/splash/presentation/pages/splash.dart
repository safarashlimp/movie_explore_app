import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:movie_discovery_app/core/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
    Timer(const Duration(seconds: 3), () {
      if (mounted) context.go('/usernamepage');
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  //color: AppTheme.accentColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Image(
                  image: AssetImage('assets/icons/logos_netflix.png'),
                  fit: BoxFit.fill,
                  width: 210,
                  height: 48,
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                  color: AppTheme.accentColor, strokeWidth: 2),
            ],
          ),
        ),
      ),
    );
  }
}
