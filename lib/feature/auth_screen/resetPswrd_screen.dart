// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/widgets/reusable_buttons.dart';
import 'package:ice_chat/core/widgets/error_widget.dart';
import 'package:ice_chat/services/firebaseAuth_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResetScreen extends ConsumerStatefulWidget {
  const ResetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetScreenState();
}

class _ResetScreenState extends ConsumerState<ResetScreen> {
  //
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final resetPswrdprovideRef = ref.watch(firebaseAuthprovideService);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Reset Password',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black38),
        ),
      ),
      //extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            border: Border.all(width: 2, color: Colors.white30),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Gap(24),
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
                          borderSide: const BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Email",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  const Gap(
                    16,
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

                              await resetPswrdprovideRef.resetPassword(
                                  context, _emailController.text);

                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future rstPswrd() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: const CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      // displayMessage(
      //     "Password reset email sent successfully!, check your mail", context);
      // ignore: use_build_context_synchronously
      displayMessage(
          "Password reset email sent successfully!, check your mail", context);
    } on FirebaseAuthException catch (e) {
      // Handle errors if the password reset email cannot be sent
      print('Error sending password reset email: $e');
      displayMessage("Reset link not sent, please try again", context);
    }
  }
}
