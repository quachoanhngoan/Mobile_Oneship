import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';

ValueNotifier<bool> fontChange = ValueNotifier<bool>(false);

class Themings {
  //black if dark, white if light

  static double? getOpacityNav(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? 1 : null;
  }

  static final headlineSmall = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w800,
    color: Colors.grey,
  );

  static final headlineMedium = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    color: Colors.grey,
  );

  static final headlineLarge = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w800,
    color: Colors.grey,
  );

  static final appbarTheme = AppBarTheme(
    centerTitle: true,
    elevation: 0,
    toolbarTextStyle: TextStyle(
      fontSize: 18.sp,
      color: Colors.black,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      fontSize: 18.sp,
      color: Colors.black,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: Colors.white,
  );

  static final appbarDarkTheme = AppBarTheme(
      centerTitle: true,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        color: Colors.white,
        letterSpacing: 1,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: Colors.grey);

  static const listTileTheme = ListTileThemeData(
    iconColor: Colors.grey,
    titleTextStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
  static final labelSmall = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    wordSpacing: 0.1,
    letterSpacing: 0.1,
  );
  static final labelMedium = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static final ThemeData lightTheme = ThemeData(
    // useMaterial3: false,
    dividerColor: Colors.transparent,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    fontFamily: "Mulish",
    listTileTheme: listTileTheme,
    // canvasColor: Colors.black,
    dividerTheme: DividerThemeData(
      space: 10,
      thickness: 1,
      color: Colors.grey.shade200,
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: AppColors.textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      //border bottom
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      prefixIconColor: AppColors.placeHolderColor,

      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: AppColors.borderColor,
        ),
      ),
      hintStyle: TextStyle(
        color: AppColors.placeHolderColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    ),

    appBarTheme: appbarTheme,
    brightness: Brightness.light,

    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      // selectedItemColor: AppColors.bgPrimaryColor,
      unselectedItemColor: Colors.grey,
    ),
    primaryColor: AppColors.primary,
    focusColor: AppColors.primary,
    hintColor: Colors.black,
    indicatorColor: AppColors.primary,
    iconTheme: const IconThemeData(color: Colors.black),

    textTheme: TextTheme(
      headlineSmall: headlineSmall,
      headlineMedium: headlineMedium,
      headlineLarge: headlineLarge,
      displaySmall: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      displayMedium: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      displayLarge: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18.0.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0.sp,
        color: AppColors.textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.0.sp,
        color: AppColors.textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
      ),
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    ),
  );
}
