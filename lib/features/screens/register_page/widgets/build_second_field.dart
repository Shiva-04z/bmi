
import 'package:bmi/core/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/build_label.dart';

import '../register_page_controller.dart';

class BuildSecondField extends StatelessWidget {

  const BuildSecondField({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterPageController controller = Get.find<RegisterPageController>();
    return RepaintBoundary(
      child: Obx(()=> controller.hasNext.value?  TextFormField(
        controller: controller.emailController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: controller.onEmailChanged,
        validator: controller.validateEmail,
        decoration: InputDecoration(
          label: const BuildLabel(text: "EMAIL"),
          hintText: "Enter your email address",
          prefixIcon: const Icon(Icons.mail,color:AppColors.buttonBackgroundColor ,),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ):
      TextFormField(
        controller: controller.confirmPasswordController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: 14,
        onChanged: controller.onConfirmPasswordChanged,
        validator: controller.validateConfirmPassword,
        obscureText: controller.isObscureConfirmText.value,
        decoration: InputDecoration(
          counterText: "",
          label: const BuildLabel(text: "CONFIRM PASSWORD"),
          hintText: "Re Enter your Password",
          prefixIcon: const Icon(Icons.lock,color: AppColors.buttonBackgroundColor,),
          suffixIcon: IconButton(
            onPressed: () {
              controller.isObscureConfirmText.toggle();
            },
            icon: controller.isObscureConfirmText.value
                ? const Icon(Icons.remove_red_eye,color: AppColors.buttonBackgroundColor)
                : const Icon(Icons.password_rounded,color: AppColors.buttonBackgroundColor),
          ),

          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),)
    );
  }
}
