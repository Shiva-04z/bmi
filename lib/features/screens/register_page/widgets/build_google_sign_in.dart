
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/colors.dart';
import '../../../widgets/loading_animation.dart';
import '../register_page_controller.dart';




class BuildGoogleSignIn extends StatelessWidget {
  const BuildGoogleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterPageController controller = Get.find<RegisterPageController>();
    return Obx(
          () =>
          SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: (controller.isRegisterPressed.value)
                  ? null
                  : controller.onGoogleSignInPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBackgroundColor,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              icon: ImageIcon(AssetImage("assets/icons/google.png"),size: 20,color: Colors.white,),
              label: Obx(
                    () =>
                (controller.isGooglePressed.value)
                    ? const LoadingAnimation()
                    : Text(
                  "Continue WITH GOOGLE",
                  style: GoogleFonts.poppins(
                    color: AppColors.buttonTextColor,
                  ),
                ),
              ),
            ),
          ),
    )
    ;
  }
}
