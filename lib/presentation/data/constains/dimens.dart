import 'package:flutter/material.dart';

class Dimens {
  //Spacer
  static const spacing2 = 2.0;
  static const spacing3 = 3.0;
  static const spacing4 = 4.0;

  static const spacing5 = 5.0;
  static const spacing6 = 6.0;
  static const spacing7 = 7.0;
  static const spacing8 = 8.0;
  static const spacing12 = 12.0;
  static const spacing15 = 15.0;
  static const spacing16 = 15.0;
  static const spacing14 = 14.0;
  static const spacing18 = 18.0;
  static const spacing20 = 20.0;
  static const spacing22 = 22.0;
  static const spacing24 = 24.0;
  static const spacing25 = 25.0;
  static const spacing80 = 80.0;
  static const spacing30 = 30.0;
  static const spacing32 = 32.0;
  static const spacing28 = 28.0;
  static const spacing40 = 40.0;
  static const spacing46 = 46.0;
  static const spacing50 = 50.0;
  static const spacing56 = 56.0;
  static const spacing150 = 150.0;
  static const spacing120 = 120.0;
  static const spacing100 = 100.0;
  static const spacing10 = 10.0;
  static const spacing9 = 9.0;
  static const spacing90 = 90.0;
  static const spacing70 = 70.0;
  static const spacing60 = 60.0;
  static const spacing98 = 98.0;
  static const spacing210 = 210.0;

  //Button
  static const buttonRadius = 15.0;
  static const buttonBorderWidth = 2.0;
  static const buttonHeight = 50.0;
  static const textButtonHeight = 25.0;
  static const buttonHorizontalPadding = 12.0;
  static const backButton = 32.0;

  //Text Field
  static const textFieldRadius = 15.0;
  static const textFieldBorderWidth = 1.8;

  //Text Field
  static const imageRadius = 8.0;

  //Size
  static const size6 = Size(6, 6);
  static const size10 = Size(10, 10);
  static const size15x20 = Size(15, 20);
  static const size24 = Size(24, 24);
  static const size20 = Size(20, 20);
  static const size28 = Size(28, 28);
  static const size40 = Size(40, 40);
  static const size32 = Size(32, 32);
  static const size36 = Size(36, 36);
  static const size50 = Size(50, 50);
  static const size100 = Size(100, 100);
  static const size150 = Size(150, 150);
  static const size120 = Size(120, 120);
  static const size15x25 = Size(15, 25);

  //Ratio
  static const ratio50 = 0.5;
  static const ratio60 = 0.6;
  static const ratio70 = 0.7;
  static const ratio80 = 0.8;
  static const ratio45 = 0.45;
  static const ratio40 = 0.4;
  static const ratio35 = 0.35;
  static const ratio30 = 0.3;
  static const ratio20 = 0.2;
  static const ratio15 = 0.15;
  static const ratio13 = 0.13;

  static const ratio10 = 0.1;
  static const ratio90 = 0.90;
  static const ratio85 = 0.85;

  //Icon
  static const icon32 = 32.0;
  static const icon35 = 35.0;
  static const icon45 = 45.0;
  static const icon40 = 40.0;
  static const icon48 = 48.0;
  static const icon20 = 20.0;
  static const icon18 = 18.0;
  static const icon25 = 25.0;
  static const icon30 = 30.0;
  static const icon120 = 120.0;
  static const icon60 = 60.0;
  static const icon13 = 13.0;
  static const icon15 = 15.0;
  static const icon80 = 80.0;
  static const icon140 = 140.0;
  static const icon105 = 105.0;

  //Navigation Bar
  static const navigationBarHeight = 80.0;
  //Bottom sheet
  static const headerHeight = 50.0;

  //Radius
  static const radius6 = 6.0;
  static const radius20 = 20.0;
  static const radius10 = 10.0;
  static const radius14 = 14.0;
  static const radius12 = 12.0;
  static const radius16 = 16.0;
  static const radius18 = 18.0;
  static const radius24 = 24.0;
  static const radius25 = 25.0;
  static const radius2 = 2.0;
  static const radius4 = 4.0;
  static const radius32 = 32.0;
  static const radius70 = 70.0;
  static const radius200 = 200.0;

  size(context) => MediaQuery.of(context).size;
}

class VSpacing extends StatelessWidget {
  const VSpacing({super.key, this.spacing});

  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spacing ?? Dimens.spacing7,
    );
  }
}

class HSpacing extends StatelessWidget {
  const HSpacing({super.key, this.spacing});

  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: spacing ?? Dimens.spacing5,
    );
  }
}
