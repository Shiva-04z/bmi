import 'package:bmi/features/screens/home_page/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../../widgets/build_label.dart';

class BuildNameField extends StatelessWidget {
  const BuildNameField({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.find<HomePageController>();
    return TextFormField(
      controller: controller.nameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 14,
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
    ) ;
  }
}
