import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_chat/feature/splashscreen.dart';
import 'package:ice_chat/firebase_options.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/services/firebaseNoti_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ice chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mOnboardingColor1),
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            // titleTextStyle: TextStyles.onboard,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
