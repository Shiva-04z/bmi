import 'package:bmi/features/screens/profile_page/profile_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../widgets/build_label.dart';

class BuildHeightSelection extends StatelessWidget {
  const BuildHeightSelection({super.key});

  int cmToInch(int cm) {
    return (cm / 2.54).round();
  }

  int inchToCm(int inch) {
    return (inch * 2.54).round();
  }


  String _formatInchesToFeetInches(int totalInches) {
    int feet = totalInches ~/ 12;
    int inches = totalInches % 12;
    return "$feet' $inches\"";
  }

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BuildLabel(text: "HEIGHT"),
        const SizedBox(height: 8),

        Obx(
          () => Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text("cm"),
                  selected: controller.isHeightCm.value,
                  onSelected: (selected) {
                    controller.isHeightCm.value = selected;
                    if (selected) {
                      controller.isHeightInch.value = false;
                      controller.selectedHeight.value = 170;
                    }
                  },
                  backgroundColor: AppColors.geryTextColor,
                  selectedColor: AppColors.deepHeaderColor,
                  labelStyle: TextStyle(
                    color: controller.isHeightCm.value
                        ? AppColors.whiteTextColor
                        : AppColors.deepTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: const Text("ft/in"),
                  selected: controller.isHeightInch.value,
                  onSelected: (selected) {
                    controller.isHeightInch.value = selected;
                    if (selected) {
                      controller.isHeightCm.value = false;
                      // Reset to default inches value (5'8" = 68 inches)
                      controller.selectedHeight.value = 68;
                    }
                  },
                  backgroundColor: AppColors.geryTextColor,
                  selectedColor: AppColors.deepHeaderColor,
                  labelStyle: TextStyle(
                    color: controller.isHeightInch.value
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
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.geryTextColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.geryTextColor.withOpacity(0.3)),
          ),
          child: Obx(
            () => Text(
              controller.isHeightCm.value
                  ? "Current: ${controller.selectedHeight.value} cm"
                  : "Current: ${_formatInchesToFeetInches(controller.selectedHeight.value)} (${controller.selectedHeight.value} in)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.deepTextColor,
              ),
            ),
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
                child: Obx(() {
                  if (controller.isHeightCm.value) {
                    return _buildCmWheel(controller);
                  } else {
                    return _buildInchWheel(controller);
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Obx(
                  () => Text(
                    controller.isHeightCm.value ? "cm" : "in",
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.geryTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInchWheel(ProfilePageController controller) {
    return ListWheelScrollView.useDelegate(
      key: const ValueKey("inchWheel"),
      // Important!
      itemExtent: 50,
      diameterRatio: 1.5,
      onSelectedItemChanged: (index) {
        controller.selectedHeight.value = controller.heightRangeInch[index];
      },
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          final value = controller.heightRangeInch[index];
          return Center(
            child: Text(
              _formatInchesToFeetInches(value),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        },
        childCount: controller.heightRangeInch.length,
      ),
    );
  }

  Widget _buildCmWheel(ProfilePageController controller) {
    return ListWheelScrollView.useDelegate(
      key: const ValueKey("cmWheel"),
      // Important!
      itemExtent: 50,
      diameterRatio: 1.5,
      onSelectedItemChanged: (index) {
        controller.selectedHeight.value = controller.heightRangeCm[index];
      },
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          final value = controller.heightRangeCm[index];
          return Center(
            child: Text(
              value.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        },
        childCount: controller.heightRangeCm.length,
      ),
    );
  }
}
