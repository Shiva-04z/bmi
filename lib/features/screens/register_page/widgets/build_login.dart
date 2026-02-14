import 'package:bmi/core/colors.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../register_page_controller.dart';


class BuildLogin extends StatelessWidget {
  const BuildLogin({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterPageController controller = Get.find<RegisterPageController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Already have an Account ?",
            style: GoogleFonts.poppins(color: AppColors.geryTextColor),
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.buttonBackgroundColor),
            ),
            TextButton(
              onPressed: controller.navigateToLogin,
              child: Text(
                "LOGIN",
                style: GoogleFonts.poppins(
                  color: AppColors.deepButtonColor,
                  fontSize: 20,
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.buttonBackgroundColor),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
