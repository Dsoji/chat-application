import 'package:get/get.dart';
import 'package:snow_chat/screens/onboarding/controller.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
