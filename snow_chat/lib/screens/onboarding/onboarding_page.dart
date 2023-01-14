// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:snow_chat/constants/constants.dart';

import 'package:snow_chat/screens/main_page.dart';
import 'package:snow_chat/screens/onboarding/controller.dart';

import 'package:snow_chat/widgets/reusable_button.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueGrey.shade50),
                child: Image.asset('assets/images/amico.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Let's get started",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "A better way to communicate!",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              ColorButton(
                  width: 300.w,
                  color: mOnboardingColor1,
                  text: "Get Started",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
