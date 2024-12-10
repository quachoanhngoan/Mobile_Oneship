import 'package:intl/intl.dart';

extension TimeExtention on DateTime? {
  //DateFormat('yyyy-MM-dd')
  String toFormatDate() {
    if (this == null) return "";
    return DateFormat('yyyy-MM-dd').format(this!);
  }

  String getWeekDay() {
    if (this == null) return "";
    //hôm nay
    if (this!.day == DateTime.now().day &&
        this!.month == DateTime.now().month &&
        this!.year == DateTime.now().year) {
      return "Hôm nay";
    }
    return DateFormat('EEEE', "vi").format(this!);
  }
}
