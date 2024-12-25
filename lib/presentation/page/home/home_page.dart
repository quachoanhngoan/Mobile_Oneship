import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/routes/app_router.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                context.pushWithNamed(context, routerName: AppRoutes.store);
              },
              child: const Text("Quản lý cửa hàng")),
          ElevatedButton(
              onPressed: () {
                context.pushWithNamed(context,
                    routerName: AppRoutes.registerpage, arguments: true);
              },
              child: const Text("Đăng ký")),
          ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
              child: const Text("Đăng xuất")),
          ElevatedButton(onPressed: () {}, child: const Text("Thực đơn")),
        ],
      ),
    );
  }
}
