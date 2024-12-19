import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/widget/skleton/skelton.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;
  final bool isAuth;
  final Widget? widgetErrorImage;
  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = AppDimensions.borderRadius,
    this.isAuth = true,
    this.widgetErrorImage,
  });

  final String src;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        httpHeaders: {
          'Authorization': 'Bearer ${prefManager.token}',
        },
        fit: fit,
        imageUrl: src,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) => const Skeleton(),
        errorWidget: (context, url, error) =>
            widgetErrorImage ?? const Skeleton(),
      ),
    );
  }
}
