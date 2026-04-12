import 'package:flutter/material.dart';

class AppColors {

  static const Color kineticGreen = Color(0xFF4ADE80); 
  static const Color pulseBlue = Color(0xFF60A5FA); 
  static const LinearGradient actionGradient = LinearGradient(
    colors: [kineticGreen, pulseBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Dark Mode Palette 
  static const Color backgroundDark = Color(0xFF001208); 
  static const Color surfaceGreen = Color(0xFF001A0B); 
  static const Color borderStrokeDark = Color.fromRGBO(74, 222, 128, 0.1);
  static const Color textHighDark = Color(0xFFF8FAFC); 
  static const Color textMediumDark = Color(0xFF94A3B8); 
  static const Color textLowDark = Color(0xFF475569); 

  // Light Mode Palette 
  static const Color backgroundLight= Color(0xFFFFFFFF); 
  static const Color softSlate = Color(0xFFF8FAFC);
  static const Color borderStrokeLight = Color(0xFFE2E8F0); 
  static const Color textHighLight = Color(0xFF0F172A); 
  static const Color textMediumLight = Color(0xFF475569);
  static const Color textLowLight = Color(0xFF94A3B8);

  // Semantic Colors
  static const Color success = kineticGreen;       
  static const Color warning = Color(0xFFFBBF24);  
  static const Color danger = Color(0xFFF87171);   
  static const Color calories = Color(0xFFFB923C); 
  static const Color black = Colors.black;
 
}



