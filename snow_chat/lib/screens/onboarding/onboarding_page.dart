// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snow_chat/constants/constants.dart';
import 'package:snow_chat/screens/register_screen.dart';
import 'package:snow_chat/widgets/reusable_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 120.4.h),
                      SizedBox(
                        height: 350.h,
                        child: Center(
                            child: Image.asset("assets/images/amico.png")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 10.h,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "You've got a long link?",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 28,
                                    color: Colors.black),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "So you have a long weblink and you are trying to reduce before you share it.",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: mOnboardingColor1,
                  child: Column(
                    children: [
                      SizedBox(height: 120.4.h),
                      SizedBox(
                        height: 250,
                        child:
                            Center(child: Image.asset("assets/images/bro.png")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 50.h,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Use Abbrefy",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 28,
                                    color: Colors.white),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Use Abbrefy to shorten your links easily, just paste and abbrefy.",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 120.4.h),
                      SizedBox(
                        height: 300.h,
                        child: Center(
                            child: Image.asset("assets/images/fiki.png")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 35.h,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Abbrefy",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 28,
                                    color: Colors.black),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Shorten your link for free, let's go!!!",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 1,
            child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        SizedBox(width: 50.w),
                        ColorButton(
                          width: 100.w,
                          color: mOnboardingColor1,
                          text: "Next",
                          onPressed: () => controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        TransparentButton(
                          width: 100.w,
                          text: "Skip",
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                                (route) => false);
                          },
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const WormEffect(
                            spacing: 16,
                            dotColor: Colors.black,
                            activeDotColor: Colors.white),
                      )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
