import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/presentation/data/constains/dimens.dart';
import 'package:oneship_merchant_app/presentation/data/constains/font.dart';
import 'colors.dart';

// class AppThemeData {
//   final Brightness brightness;
//   final AppColorScheme colorScheme;
//   final AppTextTheme textThemeT1;
//   final AppTextTheme textThemeT2;
//   final AppTextTheme textThemeT3;
//   final AppTextTheme textThemeT4;
//   final AppTextTheme buttonThemeT1;
//   final AppTextTheme buttonThemeT2;
//   final AppTextTheme borderThemeT1;
//   final AppTextTheme buttonTitleThemeT1;

//   const AppThemeData.raw({
//     required this.brightness,
//     required this.colorScheme,
//     required this.textThemeT1,
//     required this.textThemeT2,
//     required this.textThemeT3,
//     required this.buttonThemeT1,
//     required this.buttonThemeT2,
//     required this.textThemeT4,
//     required this.borderThemeT1,
//     required this.buttonTitleThemeT1,
//   });

  // factory AppThemeData({
  //   required Brightness brightness,
  //   required AppColorScheme colorScheme,
  // }) =>
  //     AppThemeData.raw(
  //         brightness: brightness,
  //         colorScheme: colorScheme,
  //         textThemeT1: AppTextTheme.create(color: colorScheme.textColor),
  //         textThemeT2: AppTextTheme.create(
  //             color: colorScheme.textColor.withOpacity(0.6)),
  //         textThemeT3: AppTextTheme.create(
  //             color: colorScheme.textColor.withOpacity(0.5)),
  //         textThemeT4: AppTextTheme.create(
  //             color: colorScheme.textColor.withOpacity(0.2)),
  //         buttonThemeT1: AppTextTheme.create(color: colorScheme.btnColor),
  //         buttonThemeT2:
  //             AppTextTheme.create(color: colorScheme.btnColor.withOpacity(0.5)),
  //         borderThemeT1: AppTextTheme.create(
  //           color: colorScheme.btnColor,
  //         ),
  //         buttonTitleThemeT1: AppTextTheme.create(
  //           color: colorScheme.textBtnColor,
  //         ));

  // ThemeData get themeData => ThemeData(
  //     brightness: brightness,
  //     primaryColor: colorScheme.primary,
  //     appBarTheme: AppBarTheme(
  //       foregroundColor: colorScheme.primary,
  //       backgroundColor: colorScheme.primary,
  //     ),
  //     tabBarTheme: TabBarTheme(
  //       labelColor: colorScheme.primary,
  //     ),
  //     scaffoldBackgroundColor: colorScheme.primary,
  //     elevatedButtonTheme: ElevatedButtonThemeData(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all(colorScheme.btnColor),
  //       ),
  //     ),
  //     textSelectionTheme:
  //         TextSelectionThemeData(cursorColor: colorScheme.textColor),
  //     iconTheme:
  //         IconThemeData(color: colorScheme.iconColor, size: Dimens.icon15),
  //     colorScheme: ColorScheme.light(
  //       brightness: brightness,
  //       primary: colorScheme.primary,
  //       surface: ColorApp.white,
  //       onPrimary: ColorApp.white,
  //     ).copyWith(background: colorScheme.primary));

  // factory AppThemeData.light() => AppThemeData(
  //     brightness: Brightness.light, colorScheme: AppColorScheme.light());

  // factory AppThemeData.dark() => AppThemeData(
  //     brightness: Brightness.dark, colorScheme: AppColorScheme.dark());
// }

class AppTextTheme {
  final TextStyle bigTitle;
  final TextStyle title;
  final TextStyle button;
  final TextStyle textButton;
  final TextStyle header0;
  final TextStyle header1;
  final TextStyle header2;
  final TextStyle body;
  final TextStyle light;
  final TextStyle error;
  final TextStyle placeHolder;
  final TextStyle small;
  final TextStyle caption;

  AppTextTheme({
    required this.bigTitle,
    required this.title,
    required this.button,
    required this.textButton,
    required this.header0,
    required this.header1,
    required this.header2,
    required this.body,
    required this.light,
    required this.error,
    required this.placeHolder,
    required this.small,
    required this.caption,
  });

  factory AppTextTheme.create({Color? color}) {
    final fontMulishBold = FontApp.mulishBold.name;
    final fontMulishExtraLight = FontApp.mulishExtra.name;
    final fontMulishWgh = FontApp.mulishWgh.name;

    return AppTextTheme(
      bigTitle: TextStyle(
        fontFamily: fontMulishBold,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: color,
      ),
      title: TextStyle(
        fontFamily: fontMulishBold,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: color,
      ),
      button: TextStyle(
        fontFamily: fontMulishBold,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: color,
      ),
      textButton: TextStyle(
        fontFamily: fontMulishExtraLight,
        fontSize: 15,
        color: color,
      ),
      header0: TextStyle(
        fontFamily: fontMulishWgh,
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: color,
      ),
      header1: TextStyle(
        fontFamily: fontMulishWgh,
        fontWeight: FontWeight.bold,
        fontSize: 21,
        color: color,
      ),
      header2: TextStyle(
        fontFamily: fontMulishWgh,
        fontSize: 16,
        color: color,
      ),
      body: TextStyle(
        fontFamily: fontMulishWgh,
        fontSize: 16,
        color: color,
      ),
      light: TextStyle(
        fontFamily: fontMulishWgh,
        fontSize: 13,
        color: color,
      ),
      error: TextStyle(
        fontFamily: fontMulishWgh,
        fontSize: 17,
        color: color,
      ),
      placeHolder: TextStyle(
        fontFamily: fontMulishWgh,
        fontSize: 15,
        color: color,
      ),
      small: TextStyle(
        fontFamily: fontMulishWgh,
        fontSize: 12,
        color: color,
      ),
      caption: TextStyle(
        fontFamily: fontMulishWgh,
        fontSize: 14,
        color: color,
      ),
    );
  }
}
