import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_LocationOfService.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_termsAndConditions.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_typeOfService.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';

import 'cubit/register_store_cubit.dart';

class RegisterStorePage extends StatefulWidget {
  const RegisterStorePage({super.key});

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  late RegisterStoreCubit bloc;
  @override
  void initState() {
    // TODO: implement initState
    bloc = injector.get<RegisterStoreCubit>();
    super.initState();
  }

  @override
  void dispose() {
    bloc.pageController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: AppButton(
              isEnable: state.isButtonNextEnable(),
              padding: EdgeInsets.symmetric(
                vertical: 10.sp,
                horizontal: 12.sp,
              ),
              onPressed: () {
                bloc.setNextPage();
              },
              text: "Tiếp tục",
            ),
          ),
          appBar: AppBarAuth(
            title: state.currentPage.title,
            isShowHelpButton: false,
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: bloc.pageController,
            children: [
              TermsAndConditionsPage(
                initialAcceptTermsAndConditions:
                    state.isAcceptTermsAndConditions,
                onAcceptTermsAndConditions: (value) {
                  bloc.setAcceptTermsAndConditions(value);
                },
              ),
              const StepTypeOfService(),
              const StepLocationOfService(),
            ],
          ),
        );
      },
    );
  }
}
