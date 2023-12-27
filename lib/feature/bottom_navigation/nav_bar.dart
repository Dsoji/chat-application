import 'package:flutter/material.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/feature/bottom_navigation/bottom_nav.dart';
import 'package:ice_chat/feature/chat_screens/chat_user.dart';
import 'package:ice_chat/feature/feeds/feeds_page.dart';
import 'package:ice_chat/feature/profile/profile_page.dart';
import 'package:iconsax/iconsax.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({
    super.key,
  });

  @override
  State<NaviBar> createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  late List<Widget> pageList = [
    FeedsPage(),
    const ChatScreen(),
    const ProfilePage(),
  ];
  int pageIndex = 0;
  Color color = Colors.grey;
  void changePage(index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pageList[pageIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white),
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNav(
                  index: 0,
                  onTap: () {
                    changePage(0);
                  },
                  icon: pageIndex == 0
                      ? Icon(
                          Iconsax.flash_1,
                          color: mOnboardingColor1,
                          size: 28,
                        )
                      : const Icon(
                          Iconsax.flash_1,
                          color: Colors.grey,
                          size: 18,
                        ),
                ),
                BottomNav(
                  index: 1,
                  onTap: () {
                    changePage(1);
                  },
                  icon: pageIndex == 1
                      ? Icon(
                          Iconsax.messages,
                          color: mOnboardingColor1,
                          size: 28,
                        )
                      : const Icon(
                          Iconsax.messages,
                          color: Colors.grey,
                          size: 18,
                        ),
                ),
                BottomNav(
                  index: 2,
                  onTap: () {
                    changePage(2);
                  },
                  icon: pageIndex == 2
                      ? Icon(
                          Iconsax.personalcard,
                          color: mOnboardingColor1,
                          size: 28,
                        )
                      : const Icon(
                          Iconsax.personalcard,
                          color: Colors.grey,
                          size: 18,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
