import 'package:flutter/material.dart';
import 'package:movie_discovery_app/features/user_name/presentation/pages/user_name.dart';

class UsernameCard extends StatelessWidget {
  final Username username;

  const UsernameCard({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            username.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          username.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}