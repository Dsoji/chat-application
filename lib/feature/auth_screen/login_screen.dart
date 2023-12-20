// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/constants/reusable_buttons.dart';
import 'package:ice_chat/feature/auth_screen/register_screen.dart';
import 'package:ice_chat/feature/auth_screen/resetPswrd_screen.dart';
import 'package:ice_chat/feature/chat_screens/chat_user.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 200,
                        height: 170,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueGrey.shade50),
                        child: Image.asset('assets/fiki.png'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Your messages are waiting...",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Login and get chatting",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Welcome Back!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Email",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Password",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ));
                                }, //widget.showSignUpPage,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: mOnboardingColor1),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child: Text(
                                  'Reset password?',
                                  style: TextStyle(color: mOnboardingColor1),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ResetScreen(),
                                  ));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ColorButton(
                        width: 300,
                        color: mOnboardingColor1,
                        text: "Login",
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ));
                        },
                        textColor: Colors.white,
                      ),
                      // GestureDetector(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Center(
                      //       child: Container(
                      //         child: Row(
                      //           children: [
                      //             Container(
                      //               height: 40,
                      //               width: 40,
                      //               // elevation: 1,
                      //               decoration: const BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //               ),
                      //               child: Image.asset('assets/google.png'),
                      //             ),
                      //             const Text("Click To Sign In To Google")
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     // final provider = Provider.of<GoogleLoginProvider>(context,
                      //     //     listen: false);
                      //     // provider.googleLogin();
                      //   },
                      // )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
