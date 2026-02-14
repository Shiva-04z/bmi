import 'package:bmi/core/colors.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_bar_helpers/animate_icon.dart';
import 'app_bar_helpers/animated_text.dart';

class WelcomeAppBar extends StatelessWidget {
  static final Decoration _decoration = BoxDecoration(
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(32),
      bottomLeft: Radius.circular(32),
    ),
    gradient: AppColors.appBarGradient,
  );

  const WelcomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 30,
      expandedHeight: MediaQuery.of(context).size.height * 0.3,

      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: _decoration,
          child: SizedBox(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: SizedBox(height: 45)),
                Center(child: const AnimatedLoginIcon()),
                SizedBox(height: 20),
                const AnimatedText(),
                Expanded(child: SizedBox(height: 45)),
              ],
            ),
          ),
        ),
        centerTitle: true,
        expandedTitleScale: 1.3,
        title: Text(
          "BMI CALCULATOR",
          style: GoogleFonts.playball(
            color: AppColors.whiteTextColor,
            fontSize: 28,
          ),
        ),
      ),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(130)),
      ),
      backgroundColor: AppColors.appbarBackgroundColor,
    );
  }
}
