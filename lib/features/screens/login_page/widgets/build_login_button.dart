import 'package:bmi/core/colors.dart';
import '../login_page_controller.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class BuildLoginButton extends StatelessWidget {
  const BuildLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.find<LoginPageController>();
    return Obx(
      () => SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonBackgroundColor,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          onPressed: controller.enableLogin.value
              ? controller.onLoginPressed
              : null,
          label: controller.isLoginPressed.value
              ? const LoadingAnimation()
              : Text("LOGIN", style: GoogleFonts.poppins(color: AppColors.whiteTextColor)),
        ),
      ),
    );
  }
}
