import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_discovery_app/features/user_name/presentation/widgets/username_cart.dart';

class UserNamePage extends StatefulWidget {
  const UserNamePage({super.key});

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/home'); // Change to your dashboard route
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usernames = [
      Username(
        name: "Emenalo",
        image: "assets/images/Rectangle 2.png",
      ),
      Username(
        name: "Onyeka",
        image: "assets/images/Rectangle 3.png",
      ),
      Username(
        name: "Thelma",
        image: "assets/images/Rectangle 4.png",
      ),
      Username(
        name: "Kids",
        image: "assets/images/Rectangle 4.png",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                /// Logo & Edit
                Row(
                  children: [
                    const Spacer(),
                    const Image(
                      image: AssetImage('assets/icons/logos_netflix.png'),
                      width: 100,
                      height: 50,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                    )
                  ],
                ),

                const SizedBox(height: 70),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: usernames.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 35,
                    mainAxisSpacing: 35,
                    childAspectRatio: .85,
                  ),
                  itemBuilder: (context, index) {
                    return UsernameCard(
                      username: usernames[index],
                    );
                  },
                ),

                const SizedBox(height: 55),

                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 45,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: const Text(
                    "Add Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Username {
  final String name;
  final String image;

  Username({
    required this.name,
    required this.image,
  });
}
