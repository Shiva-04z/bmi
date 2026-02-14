import 'package:bmi/features/screens/profile_page/profile_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../widgets/build_label.dart';

class BuildWeightSection extends StatelessWidget {
  const BuildWeightSection({super.key});



  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BuildLabel(text: "WEIGHT"),
        const SizedBox(height: 8),
        Obx( ()=>
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text("kg"),
                    selected: controller.isWeightKg.value,
                    onSelected: (selected) {
                      controller.isWeightKg.value = selected;
                      if (selected) controller.isWeightLb.value = false;
                    },
                    backgroundColor: AppColors.geryTextColor,
                    selectedColor: AppColors.deepHeaderColor,
                    labelStyle: TextStyle(
                      color: controller.isWeightKg.value
                          ? AppColors.whiteTextColor
                          : AppColors.deepTextColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: const Text("lbs"),
                    selected: controller.isWeightLb.value,
                    onSelected: (selected) {
                      controller.isWeightLb.value = selected;
                      if (selected) controller.isWeightKg.value = false;
                    },
                    backgroundColor: AppColors.geryTextColor,
                    selectedColor: AppColors.deepHeaderColor,
                    labelStyle: TextStyle(
                      color: controller.isWeightLb.value
                          ? AppColors.whiteTextColor
                          : AppColors.deepTextColor,
                    ),
                  ),
                ),
              ],
            ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.geryTextColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  diameterRatio: 1.5,
                  onSelectedItemChanged: (index) {
                    controller.selectedWeight.value =
                    controller.weightRange[index];
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          controller.weightRange[index].toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    childCount: controller.weightRange.length,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Obx(() => Text(
                  controller.isWeightKg.value ? "kg" : "lb",
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.geryTextColor,
                  ),
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
