import 'package:bmi/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildForgetPassword extends StatelessWidget {
  const BuildForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.find<LoginPageController>();
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: controller.onForgotPassword,
          child: Text(
            "Forgot Password ?",
            style: GoogleFonts.aBeeZee(color: AppColors.deepButtonColor),
          ),
        ),
      ],
    );
  }
}
