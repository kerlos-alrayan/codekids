import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 🔵 Banner Background
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/profile/profile_cover.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 🟣 Profile Image
                Positioned(
                  bottom: -120,
                  left: MediaQuery.of(context).size.width / 2 -150,
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Lottie.asset(
                      'assets/images/profile/Animation - 1750519452057.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 65),

            // 🔤 Name
            const Text(
              'Kerlos AlRayan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 40),

            // 🟪 Level Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF8E52DC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/gender/boy.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'level',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '20 Questions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          value: 0.4,
                          strokeWidth: 4,
                          backgroundColor: Colors.white24,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orange),
                        ),
                      ),
                      const Text(
                        '40%',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🟪 Coune Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF8E52DC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'coune',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '119',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            // 🟪 Courses Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF8E52DC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'courses',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
