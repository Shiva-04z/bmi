import 'package:bmi/core/service/auth_service.dart';
import 'package:bmi/data/local/hive_store.dart';
import 'package:bmi/data/local/preferences_store.dart';
import 'package:bmi/data/models/profile.dart';
import 'package:bmi/data/remote/profile_repository.dart';
import 'package:bmi/navigation/routes_constant.dart';
import 'package:get/get.dart';

import '../../../core/globals/global_variables.dart' as glbv;

class SplashPageController extends GetxController {
  String appName = "BMI CALCULATOR";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await AuthService.init();
    if (PreferencesStore.getLogin()) {
      await ProfileService.getProfile();
      String profileId = PreferencesStore.getPreferredProfileId() ?? "";
      if (profileId.isNotEmpty) {
        Profile? profile =  HiveStore.loadProfile(profileId);
        if (profile.isNull) {
          await Future.delayed(const Duration(seconds: 3));
          Get.offNamed(RoutesConstant.homePage);
        }
        else{
          glbv.selectedProfile = profile!;
          await Future.delayed(const Duration(seconds: 3));
          Get.offNamed(RoutesConstant.profilePage);
        }
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Get.offNamed(RoutesConstant.homePage);
      }
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Get.offNamed(RoutesConstant.loginPage);
    }
  }
}
