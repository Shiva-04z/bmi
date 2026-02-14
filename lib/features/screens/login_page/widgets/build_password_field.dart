import 'package:bmi/core/colors.dart';
import '../../../widgets/build_label.dart';
import '../login_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class BuildPasswordField extends StatelessWidget {
  const BuildPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.find<LoginPageController>();
    return Obx(
      () => TextFormField(
        controller: controller.passwordController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: 14,
        onChanged: controller.onPasswordChanged,
        validator: controller.validatePassword,
        obscureText: controller.isObscure.value,
        decoration: InputDecoration(
          counterText: "",
          label: const BuildLabel(text: "PASSWORD"),
          hintText: "Enter your Password",
          prefixIcon: const Icon(Icons.lock,color: AppColors.buttonBackgroundColor,),
          suffixIcon: IconButton(
            onPressed: () {
              controller.isObscure.toggle();
            },
            icon: controller.isObscure.value
                ? const Icon(Icons.remove_red_eye,color: AppColors.buttonBackgroundColor)
                : const Icon(Icons.password_rounded,color: AppColors.buttonBackgroundColor),
          ),

          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );

  }
}
