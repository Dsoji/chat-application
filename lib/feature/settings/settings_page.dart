import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/appTexts.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/feature/auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<Map<String, String>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userName = prefs.getString('userName') ?? '';
    String userEmail = prefs.getString('userEmail') ?? '';

    return {
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Settings',
            style: TextStyle(
                fontSize: 20,
                color: mOnboardingColor1,
                fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const EditProfile()),
                // );
              },
              child: Text('EDIT',
                  style: TextStyle(
                      fontSize: 16,
                      color: mOnboardingColor1,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getUserDetails(),
          builder: (context, snapshot) {
            Map<String, String> userDetails =
                snapshot.data as Map<String, String>;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(22),
                  SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/default.png'),
                        ),
                        const Gap(10),
                        SizedBox(
                          height: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " ${userDetails['userName']}",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.regular24.copyWith(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                " ${userDetails['userEmail']}",
                                style: AppTextStyles.regular16.copyWith(
                                  color: mTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(25),
                  ListTile(
                    onTap: () {},
                    hoverColor: mTextColor,
                    leading: const Icon(Icons.edit_document),
                    title: const Text('Edit Profile'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logout(context);
                    },
                    child: const Text('logout'),
                  ),
                ],
              ),
            );
          }),
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
