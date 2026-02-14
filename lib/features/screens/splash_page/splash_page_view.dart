import 'package:animate_do/animate_do.dart';
import 'package:bmi/features/screens/splash_page/widgets/build_animated_logo.dart';
import 'package:bmi/features/widgets/build_label.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bmi/features/screens/splash_page/splash_page_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/colors.dart';

class SplashPageView extends GetView<SplashPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.splashGradient),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BuildAnimatedLogo(),
                    const SizedBox(height: 32),
                    FadeInLeft(
                      child: Center(
                        child: BuildLabel(text: controller.appName),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeInLeft(
                      delay: Duration(milliseconds: 300),
                      child: Text(
                        'Track Your Fitness Journey',
                        style: GoogleFonts.playball(
                          fontSize: 16,
                          color: AppColors.taglineColor,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    const LoadingAnimation(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
