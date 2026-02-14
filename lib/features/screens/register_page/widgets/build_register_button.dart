import 'package:bmi/core/colors.dart';

import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../register_page_controller.dart';


class BuildRegisterButton extends StatelessWidget {
  const BuildRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterPageController controller = Get.find<RegisterPageController>();
    return Obx(
      () =>(controller.hasNext.value)?SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonBackgroundColor,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          onPressed: controller.enableNext.value
              ? controller.onNextPressed
              : null,
          label: Text("NEXT", style: GoogleFonts.poppins(color: AppColors.whiteTextColor)),
        ),
      ): Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBackgroundColor,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: controller.onPreviousPressed,
                label:Text("Previous", style: GoogleFonts.poppins(color: AppColors.whiteTextColor)),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBackgroundColor,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: controller.registerEnable.value
                    ? controller.onRegisterPressed
                    : null,
                label: controller.isRegisterPressed.value
                    ? const LoadingAnimation()
                    : Text("Register", style: GoogleFonts.poppins(color: AppColors.whiteTextColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
