// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/widgets/reusable_buttons.dart';

import 'package:ice_chat/feature/auth_screen/register_screen.dart';
import 'package:ice_chat/feature/auth_screen/resetPswrd_screen.dart';

import 'package:ice_chat/services/firebaseAuth_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final loginprovideRef = ref.watch(firebaseAuthprovideService);
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Welcome!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: mOnboardingColor1,
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
                            fillColor: const Color.fromARGB(255, 129, 125, 125),
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
                            fillColor: const Color.fromARGB(255, 129, 125, 125),
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
                      isLoading
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: mOnboardingColor1, size: 25)
                          : ColorButton(
                              width: 300,
                              color: mOnboardingColor1,
                              text: "Next",
                              textColor: Colors.white,
                              onPressed: () async {
                                if (_emailController.text.isNotEmpty) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await loginprovideRef.signIn(
                                    context,
                                    _emailController.text,
                                    _passwordController.text,
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
