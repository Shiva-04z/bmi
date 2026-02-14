import 'package:bmi/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/service/auth_service.dart';

class NamedPageBar extends StatelessWidget {
  final String text;

  const NamedPageBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: AuthService.logOut,
          icon: Icon(Iconsax.logout, color: AppColors.whiteBackgroundColor),
        ),
      ],
      backgroundColor: AppColors.appbarBackgroundColor,
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      title: Text(
        "BMI CALCULATOR",
        style: GoogleFonts.poppins(
          color: AppColors.whiteTextColor,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,

      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          bottomRight: Radius.circular(128),
          bottomLeft: Radius.circular(128),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: AppColors.appBarGradient,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 8,
                child: Icon(
                  Icons.mediation,
                  size: 180,
                  color: AppColors.whiteTextColor.withOpacity(0.1),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 8,
                child: Icon(
                  Icons.medical_information_rounded,
                  size: 180,
                  color: AppColors.whiteTextColor.withOpacity(0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteTextColor,
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      text.split(" ")[0],
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteTextColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
