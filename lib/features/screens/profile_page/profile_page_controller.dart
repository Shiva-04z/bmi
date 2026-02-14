import 'package:bmi/data/local/hive_store.dart';
import 'package:bmi/data/models/bmi.dart';
import 'package:bmi/features/screens/profile_page/widgets/add_history_sheet.dart';
import 'package:bmi/data/remote/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bmi/core/globals/global_variables.dart' as glbv;

class ProfilePageController extends GetxController {
  final profile = glbv.selectedProfile;
  RxBool isSavePressed = false.obs;
  RxBool isHeightCm = true.obs;
  RxBool isHeightInch = false.obs;
  RxInt selectedHeight = 170.obs;
  RxBool isWeightKg = true.obs;
  RxBool isWeightLb = false.obs;
  RxBool viaUpdate = false.obs;
  RxInt selectedWeight = 70.obs;
  RxBool isLoading = true.obs;
  String isoDate ="";

  List<int> heightRangeCm = List.generate(151, (index) => index + 100);

  List<int> heightRangeInch = List.generate(97, (index) => index + 36);

  final weightRange = List.generate(201, (index) => index + 20);

  final weights = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

 void  _init() async
  {
    isLoading.value = true;
    weights.addAll(['70', '71', '72', '73', '74', '75']);
    isLoading.value = false;
  }

  void onReqAdd( ) {
    viaUpdate.value =false;
    Get.bottomSheet(
      isDismissible: false,
      AddHistorySheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void onReqEdit( ) {
    viaUpdate.value =true;
    Get.bottomSheet(
      isDismissible: false,
      AddHistorySheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }


  void onUpdatePressed()async{
    isSavePressed.value = true;
    isLoading.value = true;
    BMI bmi = _calculateBMI();
    profile.updateBMI(isoDate, bmi );
    await ProfileService.updateProfile(profile);
    isSavePressed.value =false;
    isLoading.value =false;

  }

  void onSavePressed() async {
    isSavePressed.value = true;
    isLoading.value = true;
    BMI bmi = _calculateBMI();
     profile.addBMI(bmi);
    await ProfileService.updateProfile(profile);
    isLoading.value = false;
    isSavePressed.value = false;
  }

  String getStatus()
  {
    String? latestStatus;
    final map = profile.historyMap;
    if (map.isNotEmpty) {
      final sortedKeys = map.keys.toList()..sort();
      final latestKey = sortedKeys.last;
      latestStatus = map[latestKey]?.status;
    }
    return latestStatus?? "Not Calculated";
  }

  BMI _calculateBMI() {
    double heightMeter = 0;
    double weightKg = 0;

    if (isHeightCm.value) {
      heightMeter = selectedHeight.value / 100; // cm to meter
    } else if (isHeightInch.value) {
      heightMeter = selectedHeight.value * 0.0254; // inch to meter
    }

    if (isWeightKg.value) {
      weightKg = selectedWeight.value / 1.0;
    } else if (isWeightLb.value) {
      weightKg = selectedWeight.value * 0.453592; // lb to kg
    }

    return BMI(gender: profile.gender, height: heightMeter, weight: weightKg);
  }

}
