import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors.dart';

class BuildAnimatedLogo extends StatelessWidget {
  const BuildAnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return HeartBeat(
      infinite: true,
      curve: Curves.bounceIn,
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          gradient: AppColors.logoGradient,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: AppColors.logoShadow,
              blurRadius: 25,
              spreadRadius: 5,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: const Icon(
          Icons.fitness_center_rounded,
          size: 70,
          color: AppColors.logoIconColor,
        ),
      ),
    );
  }
}
