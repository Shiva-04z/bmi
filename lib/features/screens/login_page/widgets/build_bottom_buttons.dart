import 'package:bmi/core/colors.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_page_controller.dart';

class BuildBottomButtons extends StatelessWidget {
  const BuildBottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.find<LoginPageController>();

    return Row(
      children: [
        Obx(
          () => Expanded(
            child: SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBackgroundColor,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: controller.isResetPressed.value ? null : Get.back,
                label: Text(
                  "Cancel",
                  style: GoogleFonts.poppins(color: AppColors.whiteTextColor),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Obx(
          () => Expanded(
            child: SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBackgroundColor,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: controller.isEmailCorrect.value
                    ? controller.onResetPressed
                    : null,
                label: controller.isResetPressed.value
                    ? const LoadingAnimation()
                    : Text(
                        "Reset",
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteTextColor,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
