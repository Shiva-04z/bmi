import 'package:bmi/core/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/build_label.dart';

import '../register_page_controller.dart';

class BuildFirstField extends StatelessWidget {
  const BuildFirstField({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterPageController controller = Get.find<RegisterPageController>();
    return Obx(
      () => (controller.hasNext.value)
          ? TextFormField(
              controller: controller.nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: controller.onNameChanged,
              validator: controller.validateName,
              decoration: InputDecoration(
                label: const BuildLabel(text: "Name"),
                hintText: "Enter your Name",
                prefixIcon: const Icon(
                  Icons.person,
                  color: AppColors.buttonBackgroundColor,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            )
          : TextFormField(
              controller: controller.passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 14,
              onChanged: controller.onPasswordChanged,
              validator: controller.validatePassword,
              obscureText: controller.isObscureText.value,
              decoration: InputDecoration(
                counterText: "",
                label: const BuildLabel(text: "PASSWORD"),
                hintText: "Enter your Password",
                prefixIcon: const Icon(
                  Icons.lock,
                  color: AppColors.buttonBackgroundColor,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isObscureText.toggle();
                  },
                  icon: controller.isObscureText.value
                      ? const Icon(
                          Icons.remove_red_eye,
                          color: AppColors.buttonBackgroundColor,
                        )
                      : const Icon(
                          Icons.password_rounded,
                          color: AppColors.buttonBackgroundColor,
                        ),
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
