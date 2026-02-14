import 'package:bmi/core/colors.dart';
import 'package:bmi/data/models/profile.dart';
import 'package:bmi/features/screens/home_page/home_page_controller.dart';
import 'package:bmi/features/screens/home_page/widgets/profile_over_view.dart';
import 'package:bmi/features/widgets/build_header.dart';
import 'package:bmi/features/widgets/named_page_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import './widgets/add_profile_sheet.dart';

class HomePageView extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    final String name = '${controller.operator?.userName}';
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        tooltip: "ADD Profile",
        isExtended: true,
        backgroundColor: AppColors.buttonBackgroundColor,
        elevation: 30,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(32)),
        ),
        onPressed: controller.onAddProfile,
        child: const Icon(
          Iconsax.add,
          color: AppColors.whiteBackgroundColor,
          size: 32,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          NamedPageBar(text: name),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: BuildHeader(text: "Profiles")),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 8,
              thickness: 3,
              radius: BorderRadius.all(Radius.circular(16)),
              color: AppColors.deepHeaderColor,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            sliver: Obx(
              () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return (index == 0)? InkWell(
                          onTap: controller.onAddProfile,
                          child: Card(
                            color: AppColors.whiteBackgroundColor,
                            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                            shape: const ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                            ),
                            elevation: 3,
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.buttonBackgroundColor,
                                    size: 64,
                                  ),
                                  const SizedBox(width: 12),
                                  Text("Add A Profile",style: GoogleFonts.poppins(fontSize: 32,color: AppColors.deepHeaderColor),),
                                ],
                              ),
                            ),
                          ),
                        ) :  ProfileOverView(profile: controller.profiles[index-1]);
                      }, childCount: controller.profiles.length + 1),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
