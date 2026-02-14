import 'dart:async';

import 'package:bmi/core/colors.dart';
import '../../../widgets/build_label.dart';
import '../login_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class BuildEmailField extends StatelessWidget {

  const BuildEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.find<LoginPageController>();
    return RepaintBoundary(
      child: TextFormField(
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
      ),
    );
  }
}
