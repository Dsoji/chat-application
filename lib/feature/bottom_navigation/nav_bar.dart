import 'package:flutter/material.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/feature/bottom_navigation/bottom_nav.dart';
import 'package:ice_chat/feature/chat_screens/chat_user.dart';
import 'package:ice_chat/feature/feeds/feeds_page.dart';
import 'package:ice_chat/feature/settings/settings_page.dart';

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
    const SettingPage(),
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
                          Icons.search,
                          color: mOnboardingColor1,
                          size: 28,
                        )
                      : const Icon(
                          Icons.search,
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
                          Icons.chat,
                          color: mOnboardingColor1,
                          size: 28,
                        )
                      : const Icon(
                          Icons.chat,
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
                          Icons.settings,
                          color: mOnboardingColor1,
                          size: 28,
                        )
                      : const Icon(
                          Icons.settings,
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
