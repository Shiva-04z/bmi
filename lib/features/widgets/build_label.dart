import 'package:bmi/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildLabel extends StatelessWidget {
  final String text;

  const BuildLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: GoogleFonts.poppins(fontSize: 24, color: AppColors.deepTextColor),
    );
  }
}
