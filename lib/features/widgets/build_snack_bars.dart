import 'package:bmi/core/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BuildErrorBar {

  static void showErrorBar(String title, String subtitle)
  {
    Get.snackbar(title,subtitle,backgroundColor: AppColors.errorColor,colorText:AppColors.whiteTextColor);
  }

}
