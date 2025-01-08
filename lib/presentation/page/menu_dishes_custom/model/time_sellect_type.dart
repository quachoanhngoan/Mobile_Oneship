enum DateTimeSellectType {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday
}

extension DateTimeSellectTypeExt on DateTimeSellectType {
  String get title {
    switch (this) {
      case DateTimeSellectType.monday:
        return "Thứ 2";
      case DateTimeSellectType.tuesday:
        return "Thứ 3";
      case DateTimeSellectType.wednesday:
        return "Thứ 4";
      case DateTimeSellectType.thursday:
        return "Thứ 5";
      case DateTimeSellectType.friday:
        return "Thứ 6";
      case DateTimeSellectType.saturday:
        return "Thứ 7";
      case DateTimeSellectType.sunday:
        return "Chủ nhật";
    }
  }

  // int get dayOfWeek {}
}
