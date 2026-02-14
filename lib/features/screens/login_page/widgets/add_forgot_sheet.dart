import 'package:bmi/features/screens/login_page/widgets/build_bottom_buttons.dart';
import 'package:bmi/features/screens/login_page/widgets/build_email_field.dart';
import 'package:bmi/features/widgets/build_header.dart';
import 'package:flutter/material.dart';
import '../../../../core/colors.dart';


class AddForgotSheet extends StatelessWidget {
  const AddForgotSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      padding: const EdgeInsetsGeometry.all(32),
      decoration: BoxDecoration(
        color: AppColors.whiteBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const BuildHeader(text: "Password Reset"),
          const Spacer(),
          const BuildEmailField(),
          const Spacer(),
          const Spacer(),
          const BuildBottomButtons(),
        ],
      ),
    );
  }
}
