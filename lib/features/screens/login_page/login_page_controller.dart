import 'package:bmi/core/validators/validators.dart';
import 'package:bmi/features/screens/login_page/widgets/add_forgot_sheet.dart';
import 'package:bmi/navigation/routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/service/auth_service.dart';

class LoginPageController extends GetxController {
  RxBool isObscure = true.obs;
  bool isPasswordCorrect = false;
  RxBool isEmailCorrect = false.obs;
  RxBool isGooglePressed = false.obs;
  RxBool isLoginPressed = false.obs;
  RxBool isResetPressed = false.obs;
  RxBool enableLogin = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _init();
  }

  void _init() async {
    await AuthService.init();
  }

  void onEmailChanged(String? val) {
    isEmailCorrect.value = !Validators.validateEmail(val);
    _checkLoginEnable();
  }

  String? validateEmail(String? val) {
   return isEmailCorrect.value? null: "Please Check Email";
  }

  String? validatePassword(String? val) {
    return isPasswordCorrect? null: "Please Check password is between 6-14";
  }

  void onPasswordChanged(String? val) {
    isPasswordCorrect = !Validators.validatePassword(val);
    _checkLoginEnable();
  }
  void onResetPressed()async
  {
    isResetPressed.value = true;
    await AuthService.forgotPassword(emailController.text.trim());
    Get.back();
    Get.snackbar("Password Reset", "Email Sent" ,backgroundColor: Colors.amber,colorText: Colors.white);
    isResetPressed.value =false;
  }

  void _checkLoginEnable() {
    enableLogin.value = isPasswordCorrect && isEmailCorrect.value && !(isGooglePressed.value);
  }

  void onLoginPressed() async {
    isLoginPressed.value = true;
    await AuthService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    isLoginPressed.value = false;
  }

  void onForgotPassword() {
    Get.bottomSheet(AddForgotSheet(),backgroundColor: Colors.transparent,isScrollControlled: true);
  }

  Future<void> onSignInWithGoogle() async {
    isGooglePressed.value = true;
    await AuthService.signInWithGoogle();
    isGooglePressed.value = false;
  }



  void navigateToRegister() {
    Get.offNamed(RoutesConstant.registerPage);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
