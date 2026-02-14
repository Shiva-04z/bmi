import 'package:bmi/core/colors.dart';
import 'package:bmi/features/screens/profile_page/profile_page_controller.dart';
import 'package:bmi/features/screens/profile_page/widgets/build_table.dart';
import 'package:bmi/features/screens/profile_page/widgets/chart_widget.dart';
import 'package:bmi/features/screens/profile_page/widgets/profile_page_bar.dart';
import 'package:bmi/features/widgets/build_header.dart';
import 'package:bmi/features/widgets/build_label.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:bmi/features/widgets/named_page_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "ADD Profile",
        isExtended: true,
        backgroundColor: AppColors.buttonBackgroundColor,
        elevation: 30,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(32)),
        ),
        onPressed: controller.onReqAdd,
        child: const Icon(
          Iconsax.add,
          color: AppColors.whiteBackgroundColor,
          size: 32,
        ),
      ),
      backgroundColor: AppColors.whiteBackgroundColor,
      body: CustomScrollView(
        slivers: [
          ProfilePageBar(text: controller.profile.profileName, status: ""),
          SliverPadding(padding: const EdgeInsetsGeometry.symmetric(
              vertical: 8, horizontal: 8), sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Center(child: BuildHeader(text: "Current Status")),
                const  Divider(
                  height: 8,
                  thickness: 3,
                  radius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.deepHeaderColor,
                ),
                Card(
                  color: Colors.white,
                  elevation: 3,
                  surfaceTintColor: Colors.amber,
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Obx(
                            () =>
                        (controller.isLoading.value)
                            ? LoadingAnimation()
                            : BuildLabel(text: controller.getStatus()),
                      ),
                    ),
                  ),
                ),
                const  Divider(
                  height: 8,
                  thickness: 3,
                  radius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.deepHeaderColor,
                ),
                const SizedBox(height: 20),
                const Center(child: BuildHeader(text: "Past 7 DATA")),
                const  Divider(
                  height: 8,
                  thickness: 3,
                  radius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.deepHeaderColor,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ), child: ExpansionTile(
                  title: BuildLabel(text: "GRAPH"),
                  children: [
                    Obx(() =>
                    (controller.isLoading.value) ? LoadingAnimation() : Card(
                      color: AppColors.whiteBackgroundColor,
                      child: ChartWidget(),
                    )),
                  ],
                ),
                ),
                const Divider(
                  height: 8,
                  thickness: 3,
                  radius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.deepHeaderColor,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: BuildLabel(text: "TABLE"),
                    children: [
                      Obx(() =>
                      (controller.isLoading.value) ? LoadingAnimation() : Card(
                        color: AppColors.whiteBackgroundColor,
                        child: BuildTable(),
                      )),
                    ],
                  ),
                ),
                const Divider(
                  height: 8,
                  thickness: 3,
                  radius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.deepHeaderColor,
                ),

                SizedBox(height: 50)
              ],
            ),
          ),)

        ],
      ),
    );
  }
}
