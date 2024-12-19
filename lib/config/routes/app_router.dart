import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/login/login_page.dart';
import 'package:oneship_merchant_app/presentation/page/login/login_sms_page.dart';
import 'package:oneship_merchant_app/presentation/page/on_boarding/on_boarding_page.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/register_store_page.dart';
import 'package:oneship_merchant_app/presentation/page/splash_page.dart';
import 'package:oneship_merchant_app/presentation/page/store/store_page.dart';
import 'package:oneship_merchant_app/presentation/page/welcome/welcome_page.dart';

import '../../presentation/page/register/register_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String onBoardingPage = '/onBoardingPage';
  static const String homepage = '/homepage';
  static const String loginPage = '/loginPage';
  static const String loginWithSMS = '/loginWithSMS';
  static const String registerpage = '/registerpage';
  static const String registerStorePage = '/registerStorePage';
  static const String store = '/store';
  static final routes = [
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.store,
      page: () => const StorePage(),
    ),
    GetPage(
        name: AppRoutes.onBoardingPage,
        page: () => const OnBoardingPage(),
        transition: Transition.rightToLeft,
        curve: Curves.easeOutExpo),
    // GetPage with custom transitions and bindings
    GetPage(
      name: AppRoutes.homepage,
      page: () => const HomePage(),
      transitionDuration: Duration.zero,
      // transition: Transition.noTransition,
    ),
    GetPage(
        name: AppRoutes.loginPage,
        page: () => const LoginPage(),
        transition: Transition.rightToLeft,
        curve: Curves.easeOutExpo
        // transitionDuration: Duration.zero,
        // transition: Transition.noTransition,
        ),
    GetPage(
        name: AppRoutes.loginWithSMS,
        page: () => const LoginSmsPage(),
        transition: Transition.rightToLeft,
        curve: Curves.easeOutExpo
        // transitionDuration: Duration.zero,
        // transition: Transition.noTransition,
        ),

    GetPage(
        name: AppRoutes.registerpage,
        page: () => const RegisterPage(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
        curve: Curves.easeOutExpo),
    GetPage(
        name: AppRoutes.registerStorePage,
        page: () => const RegisterStorePage(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
        curve: Curves.easeOutExpo),
  ];
}
