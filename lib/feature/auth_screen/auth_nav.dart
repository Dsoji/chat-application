import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ice_chat/feature/bottom_navigation/nav_bar.dart';
import 'package:ice_chat/feature/chat_screens/chat_user.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return const ChatScreen();
          } else {
            return const NaviBar();
          }
        },
      ),
    );
  }
}
