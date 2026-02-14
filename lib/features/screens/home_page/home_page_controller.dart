import 'package:bmi/data/local/hive_store.dart';
import 'package:bmi/data/models/operator.dart';
import 'package:bmi/data/models/profile.dart';
import 'package:bmi/features/screens/home_page/widgets/add_profile_sheet.dart';
import 'package:bmi/data/remote/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/validators/validators.dart';

class HomePageController extends GetxController {
  final operator = HiveStore.getUser();
  Profile? profile;
  RxBool isNameCorrect = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isSavePressed = false.obs;
  RxList<Profile> profiles = <Profile>[].obs;
  RxString selectedGender = "Male".obs;
  RxBool viaUpdate = false.obs;
  TextEditingController nameController = TextEditingController();
  List<DropdownMenuItem<String>> genders = [
    ...[
      "Male",
      "Female",
      "Other",
    ].map((val) => DropdownMenuItem<String>(value: val, child: Text(val))),
  ];

  void onNameChanged(String? val) {
    isNameCorrect.value = viaUpdate.value
        ? !Validators.validateName(val)
        : Validators.validateProfileName(val);
  }

  void onAddProfile() {
    viaUpdate.value = false;
    Get.bottomSheet(
      AddProfileSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void onEditProfile() {
    viaUpdate.value = true;
    Get.bottomSheet(
      AddProfileSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void onUpdatePressed() async {
    isSavePressed.value = true;
    if (profile == null) return;
    profile = profile!.copyWith(
      profileName: nameController.text.trim(),
      gender: selectedGender.value,
    );
    await ProfileService.updateProfile(profile!);
    refreshList();
    isNameCorrect.value =false;
    isSavePressed.value = false;
  }

  String? validateName(String? val) {
    return isNameCorrect.value ? null : "Can't Put duplicate or null Name";
  }

  void onSavePressed() async {
    isSavePressed.value = true;

    await ProfileService.saveProfile(
      nameController.text.trim(),
      selectedGender.value,
    );
    refreshList();

    isSavePressed.value = false;
  }

  void refreshList() {
    profiles.value = HiveStore.loadProfiles();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _init();
  }

  void _init() async {
    profiles.value = HiveStore.loadProfiles();
  }
}
