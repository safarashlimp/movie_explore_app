import 'package:flutter/material.dart';

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color(0xFF1A1A1A),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Row(
            children: const [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.notifications,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xFF2A2A2A),
          child: Column(
            children: const [
              NotificationCard(
                image:
                    "https://image.tmdb.org/t/p/w500/bAQ8O5Uw6FedtlCbJTutenzPVKd.jpg",
                title: "El Chapo",
                subtitle: "New Arrival",
                date: "Nov 6",
              ),
              Divider(
                color: Colors.black26,
                height: 1,
              ),
              NotificationCard(
                image:
                    "https://image.tmdb.org/t/p/w500/vUUqzWa2LnHIVqkaKVlVGkVcZIW.jpg",
                title: "Peaky Blinders",
                subtitle: "New Arrival",
                date: "Nov 6",
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String date;

  const NotificationCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Image.network(
            image,
            width: 110,
            height: 65,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
