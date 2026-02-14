import 'package:bmi/features/widgets/build_header.dart';

import './widgets/build_email_field.dart';
import './widgets/build_forget_password.dart';
import './widgets/build_login_button.dart';
import './widgets/build_password_field.dart';
import './widgets/build_register.dart';
import 'package:bmi/features/widgets/welcome_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/build_label.dart';
import './widgets/build_google_sign_in.dart';
import 'login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const WelcomeAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsetsGeometry.all(24),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Center(child: BuildHeader(text: "LOGIN")),
                    const Spacer(),
                    const BuildEmailField(),
                    const Spacer(),
                    const BuildPasswordField(),
                    const BuildForgetPassword(),
                    const Spacer(),
                    const BuildLoginButton(),
                    const Spacer(),
                    const BuildRegister(),
                    const Spacer(),
                    const BuildGoogleSignIn()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
