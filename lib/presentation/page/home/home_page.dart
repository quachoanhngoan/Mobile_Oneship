import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/routes/app_router.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';

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
        child: ElevatedButton(
            onPressed: () {
              context.pushWithNamed(context,
                  routerName: AppRouter.registerpage);
            },
            child: const Text("Press")),
      ),
    );
  }
}
