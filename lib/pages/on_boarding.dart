import 'package:flutter/material.dart';
import 'package:online_shopping/assets/themes/themes.dart';
import 'package:online_shopping/pages/signup.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool owner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền
          SizedBox.expand(
            child: Image.asset(
              "lib/assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Please select your role to get started",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Owner card
                GestureDetector(
                  onTap: () => setState(() => owner = true),
                  child: buildRoleCard(
                    isSelected: owner,
                    imagePath: "lib/assets/images/hotel.png",
                    title: "Looking for guests?",
                    subtitle: "Easy find guests for your hotel",
                  ),
                ),
                const SizedBox(height: 20),

                // User card
                GestureDetector(
                  onTap: () => setState(() => owner = false),
                  child: buildRoleCard(
                    isSelected: !owner,
                    imagePath: "lib/assets/images/user.png",
                    title: "Looking for a hotel?",
                    subtitle:
                        "Join our platform to find and\nbook the best hotels",
                  ),
                ),
                const Spacer(),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(
                          redirect: owner ? "owner" : "user",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff67c0fb),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: Themes.whiteTextStyle(22),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRoleCard({
    required bool isSelected,
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Material(
      elevation: isSelected ? 8.0 : 3.0,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? const Color(0xff67c0fb) : Colors.grey.shade300,
            width: 2.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff67c0fb),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                imagePath,
                width: 45,
                height: 45,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
