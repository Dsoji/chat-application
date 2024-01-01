import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/widgets/reusable_buttons.dart';
import 'package:ice_chat/services/firebaseAuth_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  bool showProgress = false;

  final _usernameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editprovideRef = ref.watch(firebaseAuthprovideService);
    return Scaffold(
      backgroundColor: grey30,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Gap(24),
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
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            const Gap(72),
            isLoading
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: mOnboardingColor1, size: 25)
                : ColorButton(
                    width: 300,
                    color: mOnboardingColor1,
                    text: "Next",
                    textColor: Colors.white,
                    onPressed: () async {
                      // final XFile? selectedImage = _selectedImage;
                      if (_usernameController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });

                        await editprovideRef.updateUserDetails(
                          _usernameController.text,
                        );

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
