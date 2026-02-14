import 'package:bmi/navigation/routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/service/auth_service.dart';
import '../../../core/validators/validators.dart';



class RegisterPageController extends GetxController {
  bool isNameCorrect = false;
  bool isEmailCorrect = false;
  bool isPasswordCorrect = false;
  bool isConfirmPasswordCorrect = false;
  RxBool hasNext = true.obs; //toggle form page 0,1 (ture for first false for second)
  RxBool enableNext = false.obs;
  RxBool registerEnable = false.obs;
  RxBool isRegisterPressed = false.obs;
  RxBool isGooglePressed = false.obs;
  RxBool isObscureText = true.obs;
  RxBool isObscureConfirmText = true.obs;



  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _init();

  }

 void  _init() async
  {
    await AuthService.init(); // FallBack No need for it though
  }

  void onEmailChanged(String? val) {
    isEmailCorrect = !Validators.validateEmail(val);
    _checkNextEnable();
  }

  String? validateEmail(String? val) {
    return isEmailCorrect ? null : "Please Check Email";
  }

  void onNameChanged(String? val) {
    isNameCorrect = !Validators.validateName(val);
    _checkNextEnable();
  }

  String? validateName(String? val) {
    return isNameCorrect ? null : "Please Check Name";
  }

  String? validatePassword(String? val) {
    return isPasswordCorrect ? null : "Please Check password is between 6-14";
  }

  void onPasswordChanged(String? val) {
    isPasswordCorrect = !Validators.validatePassword(val);
    _checkRegisterEnable();
  }

  String? validateConfirmPassword(String? val) {
    return isConfirmPasswordCorrect ? null : "Please Check password Matches";
  }

  void onConfirmPasswordChanged(String? val) {
    isConfirmPasswordCorrect = !Validators.validateConfirmPassword(
      val,
      passwordController.text.trim(),
    );
    _checkRegisterEnable();
  }

  void _checkNextEnable() {
    enableNext.value =
        isNameCorrect && isEmailCorrect && !isGooglePressed.value;
  }

  void _checkRegisterEnable() {
    registerEnable.value =
        enableNext.value &&
        isPasswordCorrect &&
        isConfirmPasswordCorrect &&
        !isGooglePressed.value;
  }

  void onNextPressed() {
    hasNext.value = false;
  }

  void onPreviousPressed() {
    hasNext.value =true;
  }

  void onRegisterPressed()async {
    isRegisterPressed.value =true;
    await AuthService.registerUser(emailController.text, passwordController.text, nameController.text);
    isRegisterPressed.value =false;
  }

  void onGoogleSignInPressed() async{
    isGooglePressed.value = true;
    await AuthService.signInWithGoogle();
    isGooglePressed.value = false;
  }

  void navigateToLogin() {
    Get.offNamed(RoutesConstant.loginPage);
  }

  void navigateToHome() {}

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
