enum FontApp { mulishBold, mulishExtra, mulishWgh}

extension FontAppExtension on FontApp {
  String get font {
    switch (this) {
      case FontApp.mulishBold:
        return 'MulishBold';
      case FontApp.mulishExtra:
        return 'MulishExtra';
      case FontApp.mulishWgh:
        return 'MulishWgh';
    }
  }
}
