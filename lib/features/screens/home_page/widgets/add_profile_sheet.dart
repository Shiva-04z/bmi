import 'package:bmi/features/screens/home_page/widgets/build_bottom_buttons.dart';
import 'package:bmi/features/screens/home_page/widgets/build_name_field.dart';
import 'package:bmi/features/widgets/build_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../widgets/build_label.dart';
import '../home_page_controller.dart';

class AddProfileSheet extends StatelessWidget {
  const AddProfileSheet({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.find<HomePageController>();
    controller.nameController.text = (controller.viaUpdate.value)? (controller.profile?.profileName ?? ""): "";
    return Container(
      height: 450,
      padding: const EdgeInsetsGeometry.all(32),
      decoration: BoxDecoration(
        color: AppColors.whiteBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
         Obx(()=>controller.viaUpdate.value ?const BuildHeader(text: "EDIT PROFILE"): const BuildHeader(text: "ADD PROFILE")),
          const Spacer(),
          const BuildNameField(),
          const Spacer(),
          DropdownButtonFormField(
            dropdownColor: AppColors.whiteBackgroundColor,
            decoration: InputDecoration(
              label: BuildLabel(text: "GENDER"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            items: controller.genders,
            initialValue: controller.selectedGender.value,

            onChanged: (val) {
              {
                controller.selectedGender.value = val!;
              }
            },
          ),
          const Spacer(),
          const BuildBottomButtons(),
        ],
      ),
    );
  }
}
