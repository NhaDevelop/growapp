import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class AppTheme {
  //
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: createMaterialColor(primaryColor),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldPrimaryLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        outlineVariant: borderColor,
      ),
      fontFamily: GoogleFonts.lexendDeca().fontFamily,
      useMaterial3: true,
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: Colors.white),
      iconTheme: IconThemeData(color: textPrimaryColorGlobal),
      textTheme: GoogleFonts.lexendDecaTextTheme(),
      dialogBackgroundColor: Colors.white,
      unselectedWidgetColor: Colors.black,
      dividerColor: borderColor,
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: radiusOnly(topLeft: 20, topRight: 20),
        ),
      ),
      cardColor: cardColor,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: primaryColor,
        unselectedLabelColor: appTextSecondaryColor,
        indicatorColor: primaryColor,
      ),
    );
  }

  // static ThemeData get darkTheme {
  //   return ThemeData(
  //     primarySwatch: createMaterialColor(primaryColor),
  //     primaryColor: primaryColor,
  //     appBarTheme: const AppBarTheme(
  //       systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
  //     ),
  //     scaffoldBackgroundColor: scaffoldDarkColor,
  //     colorScheme: ColorScheme.fromSeed(
  //       seedColor: primaryColor,
  //       outlineVariant: borderColor,
  //       onSurface: textPrimaryColorGlobal,
  //     ),
  //     fontFamily: GoogleFonts.lexendDeca().fontFamily,
  //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: scaffoldSecondaryDark),
  //     iconTheme: const IconThemeData(color: Colors.white),
  //     textTheme: GoogleFonts.lexendDecaTextTheme(),
  //     dialogBackgroundColor: scaffoldSecondaryDark,
  //     unselectedWidgetColor: Colors.white60,
  //     useMaterial3: true,
  //     bottomSheetTheme: BottomSheetThemeData(
  //       shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
  //       backgroundColor: scaffoldDarkColor,
  //     ),
  //     dividerColor: dividerDarkColor,
  //     cardColor: cardDarkColor,
  //     dialogTheme: DialogTheme(shape: dialogShape()),
  //   );
  // }
}
