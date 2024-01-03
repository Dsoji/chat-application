import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/feature/auth_screen/auth_nav.dart';

// final userProvider = Provider<UserService>((ref) => UserService());

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay and then navigate to the next page
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mOnboardingColor1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blueGrey.shade50),
              child: Image.asset('assets/amico.png'),
            ),
            const Gap(24),
            const Text(
              "Ice Chat",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
