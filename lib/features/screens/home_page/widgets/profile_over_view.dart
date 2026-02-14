import 'package:bmi/core/colors.dart';
import 'package:bmi/data/local/preferences_store.dart';
import 'package:bmi/data/models/profile.dart';
import 'package:bmi/data/remote/profile_repository.dart';
import 'package:bmi/features/screens/home_page/home_page_controller.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:bmi/navigation/routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/globals/global_variables.dart' as glbv;

class ProfileOverView extends StatelessWidget {
  final Profile profile;
  const ProfileOverView({
    super.key,
    required this.profile,
  });

  String get _latestBmi {
    if (profile.historyMap.values.isEmpty) return 'N/A';
    final bmi = profile.historyMap.values.last.bmi;
    return bmi.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    HomePageController controller= Get.find<HomePageController>();
    RxBool isChanging = false.obs;
    return Obx(
        ()=>isChanging.value?const LoadingAnimation():InkWell(
        onTap: () {
          glbv.selectedProfile = profile;
          PreferencesStore.setPreferredProfileId(profile.profileId);
          Get.offAllNamed(RoutesConstant.profilePage);
        },
        child: Card(
          color: AppColors.whiteBackgroundColor,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
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
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.buttonBackgroundColor.withOpacity(0.1),
                        AppColors.buttonBackgroundColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.medical_information_rounded,
                    color: AppColors.buttonBackgroundColor,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              profile.profileName,
                              style: GoogleFonts.poppins(
                                color: AppColors.deepHeaderColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _buildGenderChip(),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.buttonBackgroundColor.withOpacity(0.1),
                            AppColors.buttonBackgroundColor.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'BMI',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonBackgroundColor.withOpacity(0.7),
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            _latestBmi,
                            style: GoogleFonts.playball(
                              fontSize: 24,
                              color: AppColors.buttonBackgroundColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.buttonBackgroundColor.withOpacity(0.7),
                        size: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      onSelected: (value)async {
                        isChanging.value = true;
                        switch (value) {
                          case 'edit':
                            controller.profile = profile;
                            controller.onEditProfile();
                            break;
                          case 'delete':
                            await ProfileService.deleteProfile(profile);
                            controller.refreshList();
                            break;
                        }
                        isChanging.value =false;
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_rounded,
                                size: 20,
                                color: AppColors.buttonBackgroundColor,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Edit',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.deepHeaderColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_rounded,
                                size: 20,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Delete',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.buttonBackgroundColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            profile.gender.toLowerCase() == 'male'
                ? Icons.male_rounded
                : Icons.female_rounded,
            size: 14,
            color: AppColors.buttonBackgroundColor,
          ),
          const SizedBox(width: 4),
          Text(
            profile.gender,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.buttonBackgroundColor,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}