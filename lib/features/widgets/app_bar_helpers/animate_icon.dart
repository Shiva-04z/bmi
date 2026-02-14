import 'package:bmi/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class AnimatedLoginIcon extends StatelessWidget {
  const AnimatedLoginIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
        backgroundColor: AppColors.whiteBackgroundColor,
        minRadius: 30,
        maxRadius: 50,
        child: Icon(
      Iconsax.people,
      color: AppColors.buttonBackgroundColor,
      size: 52,
      shadows: [Shadow(color: AppColors.shadowColor,blurRadius: 4,offset: Offset(1, 1))],
    ));
  }
}
