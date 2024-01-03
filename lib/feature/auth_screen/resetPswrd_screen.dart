// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/widgets/reusable_buttons.dart';
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
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      //extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
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
                      fillColor: const Color.fromARGB(255, 129, 125, 125),
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
    );
  }
}
