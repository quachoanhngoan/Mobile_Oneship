import 'package:get/get.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/welcome/welcome_page.dart';

import '../../presentation/page/register/register_page.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String homepage = '/homepage';
  static const String registerpage = '/registerpage';
  static final routes = [
    GetPage(name: AppRouter.welcome, page: () => const WelcomePage()),
    // GetPage with custom transitions and bindings
    GetPage(
      name: AppRouter.homepage,
      page: () => const HomePage(),
      transitionDuration: Duration.zero,
      transition: Transition.noTransition,
    ),

    GetPage(
        name: AppRouter.registerpage,
        page: () => const RegisterPage(),
        transitionDuration: Duration.zero,
        transition: Transition.noTransition)
  ];
}
