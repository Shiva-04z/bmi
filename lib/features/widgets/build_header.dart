import 'package:bmi/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildHeader extends StatelessWidget {
  final String text;

  const BuildHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return AppColors.shaderGradient.createShader(bounds);
      },
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 48, color: AppColors.whiteTextColor,fontWeight: FontWeight.w600),
      ),
    );
  }
}
