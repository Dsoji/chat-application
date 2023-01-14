import 'package:get/get.dart';
import 'package:snow_chat/screens/onboarding/state.dart';
import 'package:snow_chat/common/routes/routes.dart';

class OnboardingController extends GetxController {
  final state = OnboardingState();
  OnboardingController();

  handleSignIn() {
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
