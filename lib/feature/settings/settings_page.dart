import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/feature/auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(53),
          Center(child: Text('settings')),
          ElevatedButton(
            onPressed: () {
              logout(context);
            },
            child: Text('logout'),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    // Clear the user details using the userDetails['userRole']Provider's clearUserDetails method.
    // Provider.of<userDetails['userRole']Provider>(context, listen: false).clearUserDetails();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');

    prefs.remove('userEmail');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
