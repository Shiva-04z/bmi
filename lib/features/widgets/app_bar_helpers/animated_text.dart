import 'package:animate_do/animate_do.dart';
import 'package:bmi/core/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedText extends StatelessWidget {

  const AnimatedText({super.key});

  @override
  Widget build(BuildContext context) {
    return  FadeInLeft(
      child: Text(
      "WELCOME TO",
      style: GoogleFonts.playball(
        fontSize: 25,
        color: AppColors.whiteTextColor,
        shadows: [Shadow(color: AppColors.shadowColor, offset: Offset(1, 1))],
      ),
      ),
    );
  }
}
