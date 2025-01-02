import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/bottom_tab/bottom_view.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/on_boarding/on_boarding_page.dart';
import 'package:oneship_merchant_app/presentation/page/store/store_page.dart';
import 'package:oneship_merchant_app/service/pref_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // initRouter();

    super.initState();
  }

  Future<String?> initRouter() async {
    try {
      final token = injector<PrefManager>().token;

      log("token authen: $token");

      if (token == null || token.isEmpty) {
        FlutterNativeSplash.remove();

        return null;
      } else {
        FlutterNativeSplash.remove();

        return token;
      }
    } catch (e) {
      FlutterNativeSplash.remove();

      return null;
    }
    /* } */
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initRouter(),
        builder: (context, value) {
          if (value.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: const Center(child: CupertinoActivityIndicator()),
              ),
            );
          }
          if (value.connectionState == ConnectionState.done) {
            if (value.data == null || value.data?.isEmpty == true) {
              return const OnBoardingPage();
            }
            return const StorePage();
          }
          return const SizedBox();
        });
  }
}
