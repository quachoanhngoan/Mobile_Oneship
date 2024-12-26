import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/theme/color.dart';

class ToppingCustomPage extends StatelessWidget {
  const ToppingCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: AppColors.black)),
        title: Text("Thêm nhóm topping",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 0.3,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
            child: Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.color988,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Lưu thông tin",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
