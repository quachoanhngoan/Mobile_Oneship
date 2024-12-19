import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/routes/app_router.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        // child: Text('Home Page'),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  context.pushWithNamed(context, routerName: AppRoutes.store);
                },
                child: const Text("Quản lý cửa hàng")),
            ElevatedButton(
                onPressed: () {
                  context.pushWithNamed(context,
                      routerName: AppRoutes.registerpage);
                },
                child: const Text("Đăng ký")),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                },
                child: const Text("Đăng xuất")),
          ],
        ),
      ),
    );
  }
}
