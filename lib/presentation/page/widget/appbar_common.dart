import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/presentation/data/constains/dimens.dart';
import 'package:oneship_merchant_app/presentation/data/constains/themes.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';

import '../../data/constains/colors.dart';

class AppBarAuth extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarAuth(
      {super.key,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorApp.white,
      leading: IconButton(
          onPressed: () {
            context.popScreen();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
          )),
      title: Text(title,
          style: AppTextTheme.create(color: ColorApp.color723).button),
      actions: [
        Center(
          child: Text(
            "Trợ giúp",
            style: AppTextTheme.create(color: ColorApp.color988).small,
          ),
        ),
        const HSpacing(spacing: 16)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
