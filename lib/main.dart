import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_chat/feature/splashscreen.dart';
import 'package:ice_chat/firebase_options.dart';
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
      darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 17, 16, 16))),
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
