import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/appTexts.dart';

class ProfileTile2 extends StatelessWidget {
  final String title;
  final Icon icon;

  final VoidCallback onTap;

  const ProfileTile2({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 49.65,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: ShapeDecoration(
          color: const Color.fromARGB(255, 185, 200, 218),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.black.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(4),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26055FE0),
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: icon,
              ),
              const Gap(20),
              Text(
                title,
                style: AppTextStyles.regular16.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
