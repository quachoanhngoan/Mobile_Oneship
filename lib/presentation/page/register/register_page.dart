import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/presentation/data/constains/colors.dart';
import 'package:oneship_merchant_app/presentation/data/constains/dimens.dart';
import 'package:oneship_merchant_app/presentation/page/widget/appbar_common.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarAuth(
        title: "Nhập SĐT/Email",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: <Widget>[
            const VSpacing(spacing: 4),
            Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Container(
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          color: ColorApp.color988,
                          borderRadius: BorderRadius.circular(100))),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
