import 'package:intl/intl.dart';

class AppUtils {
  String formatPriceCart(String? price) {
    try {
      if (price != null) {
        double number = double.parse(price);
        final formatter = NumberFormat.currency(
            locale: 'vi_VN', symbol: '', decimalDigits: 2);
        return formatter.format(number);
      }
    } catch (_) {}
    return "";
  }
}
