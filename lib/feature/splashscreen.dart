import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ice_chat/feature/chat_screens/chat_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final userProvider = Provider<UserService>((ref) => UserService());

class SplshScrn extends ConsumerStatefulWidget {
  const SplshScrn({super.key});

  @override
  ConsumerState<SplshScrn> createState() => _SplshScrnState();
}

class _SplshScrnState extends ConsumerState<SplshScrn> {
  // late final _userService = ref.watch(userProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF410F57),
      body: Center(
        child: SizedBox(
          height: 87,
          width: 83,
          child: Image.asset(''),
        ),
      ),
    );
  }
}
