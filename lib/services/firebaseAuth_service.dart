// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_chat/core/widgets/error_widget.dart';
import 'package:ice_chat/feature/auth_screen/login_screen.dart';
import 'package:ice_chat/feature/bottom_navigation/nav_bar.dart';
import 'package:ice_chat/feature/chat_screens/chat_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final firebaseAuthprovideService = Provider<FirebaseAuthprovideServiceService>(
    (ref) => FirebaseAuthprovideServiceService());

class FirebaseAuthprovideServiceService {
  final _auth = FirebaseAuth.instance;
//reset password
  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      displayMessage(
          "Password reset email sent successfully!, check mail", context);
    } on FirebaseAuthException catch (e) {
      // Handle errors if the password reset email cannot be sent
      print('Error sending password reset email: $e');
      displayMessage("Reset link not sent, please try again", context);
    }
  }

//register users
  Future<void> signinUp(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await postDetailsToFirestore(context, email, name);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      displayMessage(e.code, context);
    } finally {
      Navigator.pop(context); // Close the loading indicator
    }
  }

//store user details to a user doc file in firebase while registering
  Future<void> postDetailsToFirestore(
    BuildContext context,
    String email,
    String name,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    await ref.doc(user!.uid).set({
      'email': email,
      'name': name,
    });
  }

  ///login user
  Future<void> route(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    var userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    try {
      DocumentSnapshot documentSnapshot = await userDocRef.get();

      if (documentSnapshot.exists) {
        String userName = documentSnapshot.get('name');
        String userEmail = documentSnapshot.get('email');

        // Store user information in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userName', userName);
        prefs.setString('userEmail', userEmail);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NaviBar()),
        );
      }
    } catch (e) {
      // Handle errors if any
      print('Error fetching user data: $e');
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await route(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayMessage("User not found", context);
      } else if (e.code == 'wrong-password') {
        displayMessage("Error: check details and try again", context);
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        displayMessage('Wrong login credentials, please try again', context);
      }
    }
  }

//logout
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
