

import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerCard({super.key, this.width = 120, this.height = 180});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.cardColor,
      highlightColor: const Color(0xFF2C2C2E),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class ShimmerRail extends StatelessWidget {
  const ShimmerRail({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerCard(),
              const SizedBox(height: 6),
              Shimmer.fromColors(
                baseColor: AppTheme.cardColor,
                highlightColor: const Color(0xFF2C2C2E),
                child: Container(height: 12, width: 90, color: AppTheme.cardColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}