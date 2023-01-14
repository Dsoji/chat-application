// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:snow_chat/screens/onboarding/index.dart';

import '../../screens/auth_pages/login/index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  // static const Application = AppRoutes.Application;
  // static final RouteObserver<Route> observer = RouteObservers();
  // static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => LoginPage(
        showSignUpPage: () {},
      ),
      binding: LoginBinding(),
    )
  ];
}
