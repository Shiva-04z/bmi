import 'package:bmi/core/colors.dart';
import 'package:bmi/features/widgets/build_header.dart';
import './widgets/build_first_field.dart';
import './widgets/build_google_sign_in.dart';
import './widgets/build_login.dart';
import './widgets/build_register_button.dart';
import './widgets/build_second_field.dart';
import 'package:bmi/features/widgets/build_label.dart';
import 'package:bmi/features/widgets/welcome_app_bar.dart';
import './register_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: CustomScrollView(
        slivers: [
          const WelcomeAppBar(), // Reused Component from LoginPage
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    const BuildHeader(text: "REGISTER"),
                    const Spacer(),
                    const BuildFirstField(),
                    const Spacer(),
                    const BuildSecondField(),
                    const Spacer(),
                    const BuildRegisterButton(),
                    const Spacer(),
                    const BuildLogin(),
                    const BuildGoogleSignIn(),
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
