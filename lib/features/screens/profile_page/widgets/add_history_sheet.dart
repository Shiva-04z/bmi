import 'package:bmi/features/screens/profile_page/widgets/build_height_selection.dart';
import 'package:bmi/features/screens/profile_page/widgets/build_weight_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/colors.dart';
import '../../../widgets/build_header.dart';
import '../../../widgets/build_label.dart';
import 'build_bottom_buttons.dart';
import '../profile_page_controller.dart';

class AddHistorySheet extends StatelessWidget {
  const AddHistorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.9,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.whiteBackgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const BuildHeader(text: "Record BMI"),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BuildHeightSelection(),
                  const SizedBox(height: 24),
                  const BuildWeightSection(),
                  const SizedBox(height: 24),
                  const BuildBottomButtons()

                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }




}