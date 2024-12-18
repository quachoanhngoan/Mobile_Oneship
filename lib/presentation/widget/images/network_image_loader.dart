// import 'package:flutter/material.dart';
// import 'package:oneship_merchant_app/core/constant/dimensions.dart';

// import 'skleton/skelton.dart';

// class NetworkImageWithLoader extends StatelessWidget {
//   final BoxFit fit;
//   final bool isAuth;

//   const NetworkImageWithLoader(
//     this.src, {
//     super.key,
//     this.fit = BoxFit.cover,
//     this.radius = AppDimensions.padding,
//     this.isAuth = true,
//   });

//   final String src;
//   final double radius;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(radius)),
//       child: CachedNetworkImage(
//         httpHeaders: {
//           'Authorization': 'Bearer $token',
//         },
//         fit: fit,
//         imageUrl: isAuth ? src : this.src,
//         imageBuilder: (context, imageProvider) => Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: imageProvider,
//               fit: fit,
//             ),
//           ),
//         ),
//         placeholder: (context, url) => const Skeleton(),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//       ),
//     );
//   }
// }
