import 'package:get/get.dart';
import 'package:oneship_merchant_app/presentation/page/home/home_page.dart';
import 'package:oneship_merchant_app/presentation/page/on_boarding/on_boarding_page.dart';
import 'package:oneship_merchant_app/presentation/page/welcome/welcome_page.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String onBoardingPage = '/onBoardingPage';
  static const String homepage = '/homepage';
  static const String loginPage = '/loginPage';
  static final routes = [
    GetPage(
      name: AppRouter.welcome,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: AppRouter.onBoardingPage,
      page: () => const OnBoardingPage(),
    ),
    // GetPage with custom transitions and bindings
    GetPage(
      name: AppRouter.homepage,
      page: () => const HomePage(),
      transitionDuration: Duration.zero,
      transition: Transition.noTransition,
    )
  ];
}
