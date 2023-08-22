import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

sealed class BarbershopTheme {
  static const _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: ConstantColors.grey),
  );

  static ThemeData themeData = ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(color: ConstantColors.brown),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.black,
              fontFamily: ConstantFonts.fontFamily)),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        hintStyle: const TextStyle(
            color: ConstantColors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        filled: true,
        isDense: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: ConstantColors.grey),
        border: _defaultInputBorder,
        enabledBorder: _defaultInputBorder,
        focusedBorder: _defaultInputBorder,
        errorBorder: _defaultInputBorder.copyWith(
          borderSide: const BorderSide(
            color: ConstantColors.red,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ConstantColors.brown,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: ConstantColors.brown,
            width: 1,
          ),
          foregroundColor: ConstantColors.brown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      fontFamily: ConstantFonts.fontFamily);
}
