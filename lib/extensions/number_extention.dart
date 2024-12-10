import 'package:intl/intl.dart';

extension NumberExtension on num? {
  bool get isNullOrZero => this == null || this == 0;

  String toCurrencyFormat() {
    if (this == null) {
      return '';
    }

    return NumberFormat.currency(
      locale: 'vi',
      symbol: 'đ',
      decimalDigits: 0,
    ).format(this!);
  }

  String formatCurrencyWith1000() {
    if (this == null) {
      return '';
    }

    return NumberFormat.currency(
      locale: 'vi',
      symbol: 'đ',
      decimalDigits: 0,
    ).format(this! * 1000);
  }
}

extension DoubleExtension on double? {
  String toCurrencyFormat() {
    if (this == null) {
      return '';
    }

    return NumberFormat.currency(
      locale: 'vi',
      symbol: 'đ',
      decimalDigits: 0,
    ).format(this!);
  }

  String formatCurrencyWith1000() {
    if (this == null) {
      return '';
    }

    return NumberFormat.currency(
      locale: 'vi',
      symbol: 'đ',
      decimalDigits: 0,
    ).format(this! * 1000);
  }

  String formatCurrencyNoSymBol() {
    if (this == null) {
      return '';
    }

    return NumberFormat.currency(
      locale: 'vi',
      symbol: '',
      decimalDigits: 0,
    ).format(this! * 1000);
  }
}
