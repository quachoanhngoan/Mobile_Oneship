import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';

class RegisterStorePage extends StatefulWidget {
  const RegisterStorePage({super.key});

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarAuth(
        title: 'Đăng ký cửa hàng',
        isShowHelpButton: false,
      ),
      body: Center(
        child: Text('Register Store Page'),
      ),
    );
  }
}
