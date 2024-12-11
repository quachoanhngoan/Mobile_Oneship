import 'package:flutter/material.dart';
// import 'package:gradient_like_css/gradient_like_css.dart';

// class AppColorScheme {
//   final Color primary;
//   final Color btnColor;
//   final Color textColor;
//   final Color textBtnColor;
//   final Color cardColor;
//   final Color buttonColor;
//   final Color playBtnColor;
//   final Color iconColor;
//   final Color searchBarColor;
//   final LinearGradient cardCastColor;
//   final Color titleCastItemColor;
//   final Color borderCastItemColor;
//   final LinearGradient bgDiscoverColor;
//   final Color iconControllerColor;
//   final Color cardSettingColor;
//   AppColorScheme(
//       {required this.primary,
//       required this.btnColor,
//       required this.textColor,
//       required this.textBtnColor,
//       required this.cardColor,
//       required this.buttonColor,
//       required this.playBtnColor,
//       required this.iconColor,
//       required this.searchBarColor,
//       required this.cardCastColor,
//       required this.titleCastItemColor,
//       required this.borderCastItemColor,
//       required this.bgDiscoverColor,
//       required this.iconControllerColor,
//       required this.cardSettingColor});

//   factory AppColorScheme.light() => AppColorScheme(
//       primary: const Color(0xFFF3F6FB),
//       btnColor: ColorApp.buttonViolet,
//       textColor: Colors.black,
//       textBtnColor: Colors.white,
//       cardColor: Colors.white,
//       buttonColor: const Color(0xFFFFFFFF),
//       playBtnColor: const Color(0xFFF6F6F6),
//       iconColor: const Color(0xFF503E9D),
//       searchBarColor: const Color(0xFFE4EBF5),
//       cardCastColor: linearGradient(180, ['#FFFFFF 0%', '#F1F6FC 100%']),
//       titleCastItemColor: const Color(0xFF403761),
//       borderCastItemColor: Colors.white.withOpacity(0.71),
//       bgDiscoverColor:
//           const LinearGradient(colors: [Color(0xFFF3F6FB), Color(0xFFF3F6FB)]),
//       iconControllerColor: const Color(0xFF403761),
//       cardSettingColor: const Color(0xFFDBDBDB));

//   factory AppColorScheme.dark() => AppColorScheme(
//       primary: const Color(0xFF050505),
//       btnColor: ColorApp.buttonViolet,
//       textColor: Colors.white,
//       textBtnColor: Colors.white,
//       cardColor: const Color(0xFF1B1C1D),
//       buttonColor: const Color(0xFF1B1C1D),
//       playBtnColor: const Color(0xFFF6F6F6),
//       iconColor: Colors.white,
//       searchBarColor: const Color(0xFF1A1A1A),
//       cardCastColor: linearGradient(162, ['#303235 8.28%', '#151516 91.72%']),
//       titleCastItemColor: const Color(0xFF999999),
//       borderCastItemColor: const Color(0xFF2E2E2E).withOpacity(0.4),
//       bgDiscoverColor: linearGradient(0, ['#1B1A29 0%', '#151423 100%']),
//       iconControllerColor: Colors.white,
//       cardSettingColor: Colors.white);
// }

class ColorApp {
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color grey = Colors.grey;
  static const Color transparent = Colors.transparent;

  static const Color color1E1 = Color(0xffE1E1E1);
  static const Color color723 = Color(0xff042723);
  static const Color color988 = Color(0xff00B988);

  static const buttonViolet = Color(0xFF5B35FF);

  static Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }
}
