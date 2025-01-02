import 'package:flutter/widgets.dart';

class ImageAssetWidget extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  const ImageAssetWidget(
      {super.key,
      required this.image,
      this.width,
      this.height,
      this.fit,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      color: color,
      filterQuality: FilterQuality.medium,
    );
  }
}
