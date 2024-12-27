import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom_state.dart';

class ToppingCustomCubit extends Cubit<ToppingCustomState> {
  ToppingCustomCubit() : super(const ToppingCustomState());

  final TextEditingController nameToppingController = TextEditingController();
  final PageController pageController = PageController();

  changeStepPage(int index) {
    if (index > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Get.back();
    }
  }

  nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
