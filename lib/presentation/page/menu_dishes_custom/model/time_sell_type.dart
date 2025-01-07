enum TimeSellType { timeStore, timeOption }

extension TimeSellTypeEx on TimeSellType {
  String get title {
    switch (this) {
      case TimeSellType.timeStore:
        return "Theo giờ của quán";
      case TimeSellType.timeOption:
        return "Tuỳ chọn";
    }
  }
}
