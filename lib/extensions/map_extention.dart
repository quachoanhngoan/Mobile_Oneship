extension MapExtention on Map? {
  removeNullValues() {
    this?.removeWhere((key, value) => value == null);
  }
}
