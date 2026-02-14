import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Basic colors
  static const Color buttonTextColor = Colors.white;
  static const Color buttonBackgroundColor = Color(0xFF4527A0);
  static const Color deepHeaderColor = Colors.indigo;
  static const Color deepButtonColor = Colors.deepPurple;
  static const Color whiteTextColor = Colors.white;
  static const Color whiteBackgroundColor = Colors.white;
  static const Color deepTextColor = Color(0xFF1A237E);
  static const Color geryTextColor = Colors.grey;
  static const Color shadowColor = Colors.black;
  static const Color appbarBackgroundColor = Colors.deepPurple;
  static const Color errorColor = Colors.red;
  static const Color logoShadow = Color(0x804A148C);
  static const Color logoIconColor = Color(0xFF4A148C);
  static const Color taglineColor = Colors.white70;
  static const Color loadingIndicatorColor = Colors.white;
  static const Color loadingTextColor = Colors.white70;

  static const LinearGradient shaderGradient = LinearGradient(
    colors: [Color(0xFF1A237E), Color(0xFF7C4DFF)],
  );

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(49, 27, 146, 1.0),
      Color.fromRGBO(101, 31, 255, 1.0),
    ],
    end: Alignment.bottomCenter,
    begin: Alignment.topCenter,
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.teal, Color(0xFFB39DDB), Colors.teal],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient logoGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFE1BEE7)],
  );


}
