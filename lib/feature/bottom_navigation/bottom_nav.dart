import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  BottomNav(
      {super.key,
      required this.index,
      required this.onTap,
      required this.icon});
  final Icon icon;
  int index;
  void Function()? onTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    return IconButton(
      onPressed: onTap,
      icon: icon,
    );
  }
}
