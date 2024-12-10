extension StringExtension on String? {
  String toCapitalizedFirstLetter() {
    if (this == null || this!.isEmpty || this!.trim().isEmpty) {
      return '';
    }

    return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
  }

  String toCapitalizedFirstWord() {
    if (this == null || this!.isEmpty || this!.trim().isEmpty) {
      return '';
    }

    return this!
        .replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.toCapitalizedFirstLetter())
        .join(' ');
  }

  bool isNullOrEmptyOrWhiteSpace() {
    return (this?.trim() ?? '').isEmpty;
  }

  bool isNotNullOrEmptyOrWhiteSpace() {
    return !isNullOrEmptyOrWhiteSpace();
  }

  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNotNullOrEmpty {
    return this != null && this!.isNotEmpty;
  }

  DateTime? toDateTime() {
    if (this == null || this!.isEmpty) {
      return null;
    }

    return DateTime.tryParse(this!);
  }
}
