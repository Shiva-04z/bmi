import 'package:bmi/core/colors.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../login_page_controller.dart';

class BuildRegister extends StatelessWidget {
  const BuildRegister({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.find<LoginPageController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Don't have an Account ?",
            style: GoogleFonts.poppins(color: AppColors.geryTextColor),
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.buttonBackgroundColor),
            ),
            TextButton(
              onPressed: controller.navigateToRegister,
              child: Text(
                "REGISTER",
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
