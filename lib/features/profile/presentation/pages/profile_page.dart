import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = [
      {
        "name": "Emenalo",
        "image": "assets/images/Rectangle 2.png",
      },
      {
        "name": "Onyeka",
        "image":"assets/images/Rectangle 3.png",
      },
      {
        "name": "Thelma",
        "image": "assets/images/Rectangle 4.png",
      },
      {
        "name": "Kids",
        "image": "assets/images/Rectangle 5.png",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Profiles
              SizedBox(
                height: 95,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: profiles.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    if (index == profiles.length) {
                      return Column(
                        children: [
                          Container(
                            width: 70,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white54),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }

                    final profile = profiles[index];

                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            profile["image"]!,
                            width: 70,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          profile["name"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              /// Manage Profiles
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "Manage Profiles",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Share Card
              Container(
                width: double.infinity,
                color: const Color(0xff262626),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.chat_outlined, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Tell friends about Netflix.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis non accumsan accumsan quis. Massa.",
                      style: TextStyle(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: Colors.white54,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Copy Link",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ShareItem(
                          icon: Icons.message,
                          color: Colors.green,
                          title: "WhatsApp",
                        ),
                        _ShareItem(
                          icon: Icons.facebook,
                          color: Colors.blue,
                          title: "Facebook",
                        ),
                        _ShareItem(
                          icon: Icons.email,
                          color: Colors.orange,
                          title: "Gmail",
                        ),
                        _ShareItem(
                          icon: Icons.more_horiz,
                          color: const Color(0xff262626),
                          title: "More",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(color: Colors.white24),

              const ListTile(
                leading: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  "My List",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const Divider(color: Colors.white24),

              _menu("App Settings"),
              _menu("Account"),
              _menu("Help"),
              _menu("Sign Out"),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _menu(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onTap: () {},
    );
  }
}

class _ShareItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;

  const _ShareItem({
    required this.icon,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}