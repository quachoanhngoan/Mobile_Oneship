import 'package:flutter/material.dart';
//padding EdgeInsets

extension EdgeInsetsHelper on EdgeInsets {
  EdgeInsets top(double value) {
    return EdgeInsets.only(top: value);
  }

  EdgeInsets bottom(double value) {
    return EdgeInsets.only(bottom: value);
  }

  EdgeInsets left(double value) {
    return EdgeInsets.only(left: value);
  }

  EdgeInsets right(double value) {
    return EdgeInsets.only(right: value);
  }
  //top Mediaquery.of(context).padding.top

  EdgeInsets topSafeArea(BuildContext context) {
    return EdgeInsets.only(top: MediaQuery.of(context).padding.top);
  }

  EdgeInsets bottomSafeArea(BuildContext context) {
    return EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom);
  }

  EdgeInsets leftSafeArea(BuildContext context) {
    return EdgeInsets.only(left: MediaQuery.of(context).padding.left);
  }

  EdgeInsets rightSafeArea(BuildContext context) {
    return EdgeInsets.only(right: MediaQuery.of(context).padding.right);
  }

  EdgeInsets allSafeArea(BuildContext context) {
    return EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
      bottom: MediaQuery.of(context).padding.bottom,
      left: MediaQuery.of(context).padding.left,
      right: MediaQuery.of(context).padding.right,
    );
  }
}
