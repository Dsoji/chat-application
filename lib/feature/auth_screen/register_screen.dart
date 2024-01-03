// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/util/pick_image.dart';
import 'package:ice_chat/core/widgets/reusable_buttons.dart';
import 'package:ice_chat/feature/auth_screen/login_screen.dart';
import 'package:ice_chat/services/firebaseAuth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  Uint8List? image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  bool showProgress = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerprovideRef = ref.watch(firebaseAuthprovideService);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      //extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              const Gap(24),

              const Text(
                "Let's get started",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "A simple way to communicate, now fill details below to proceed",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38),
              ),
              const Gap(
                20,
              ),
              // Stack(
              //   children: [
              //     const CircleAvatar(
              //       radius: 50,
              //       backgroundImage: AssetImage('assets/default.png'),
              //     ),
              //   ],
              // ),
              const Gap(
                20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Username",
                    fillColor: const Color.fromARGB(255, 129, 125, 125),
                    filled: true,
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
                      borderSide: const BorderSide(color: Colors.blueGrey),
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
                      borderSide: const BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Password",
                    fillColor: const Color.fromARGB(255, 129, 125, 125),
                    filled: true,
                  ),
                ),
              ),

              ///confirm password field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  controller: _confirmpasswordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Confirm Password",
                    fillColor: const Color.fromARGB(255, 129, 125, 125),
                    filled: true,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'I am a member ',
                    style: TextStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    child: Text(
                      'Login Now',
                      style: TextStyle(
                          color: mOnboardingColor1,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
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
                      text: "Register",
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_emailController.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });

                          await registerprovideRef.signinUp(
                            context,
                            _emailController.text,
                            _passwordController.text,
                            _usernameController.text,
                          );

                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
              const Gap(
                26,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
