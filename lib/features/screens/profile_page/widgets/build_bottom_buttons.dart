import 'package:bmi/core/colors.dart';
import 'package:bmi/features/screens/profile_page/profile_page_controller.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildBottomButtons extends StatelessWidget {
  const BuildBottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();

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
                onPressed: controller.isSavePressed.value ?  null: Get.back ,
                label: Text(
                  "Cancel",
                  style: GoogleFonts.poppins(color: AppColors.whiteTextColor),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10,),
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
                onPressed:controller.isSavePressed.value?null:  (controller.viaUpdate.value? controller.onUpdatePressed:controller.onSavePressed),
                label: controller.isSavePressed.value
                    ? const LoadingAnimation()
                    : Text(
                        controller.viaUpdate.value?"Update":"Save",
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
