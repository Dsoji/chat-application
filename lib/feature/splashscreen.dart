import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFF410F57),
      body: Center(
        child: SizedBox(
          height: 87,
          width: 83,
          child: Image.asset(''),
        ),
      ),
    );
  }
}
