import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_LocationOfService.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_RepresentativeInformation.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_RepresentativeInformation.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_StoreInformation.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/register_location_service.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_terms_conditions.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/register_type_service.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';

import 'cubit/register_store_cubit.dart';
import 'widget/register_shop_info.dart';

class RegisterStorePage extends StatefulWidget {
  const RegisterStorePage({super.key});

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  late RegisterStoreCubit bloc;
  late TextEditingController nameStoreController;
  late TextEditingController specialDishController;
  late TextEditingController streetNameController;
  late TextEditingController phoneContactController;
  late TextEditingController groupServiceController;
  late TextEditingController providerController;
  late TextEditingController districtController;
  late TextEditingController streetAddressController;
  late TextEditingController parkingFeeController;

  @override
  void initState() {
    bloc = injector.get<RegisterStoreCubit>();
    nameStoreController = TextEditingController();
    specialDishController = TextEditingController();
    streetNameController = TextEditingController();
    phoneContactController = TextEditingController();
    groupServiceController = TextEditingController();
    providerController = TextEditingController();
    districtController = TextEditingController();
    streetAddressController = TextEditingController();
    parkingFeeController = TextEditingController();
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
            onPressed: () {
              bloc.setPreviousPage();
            },
            title: state.currentPage.title,
            isShowHelpButton: false,
          ),
          body: Column(
            children: [
              state.currentPage.index != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(7, (index) {
                            return Expanded(
                              child: AnimatedContainer(
                                margin: const EdgeInsets.only(right: 5),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInCubic,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: index < state.currentPage.index
                                        ? AppColors.primary
                                        : AppColors.textGray,
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            );
                          }),
                        ),
                      ),
                    )
                  : Container(),
              Flexible(
                child: PageView(
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
                    RegisterTypeOfService(
                      state: state,
                      bloc: bloc,
                    ),
                    RegisterLocationOfService(
                      state: state,
                      bloc: bloc,
                    ),
                    RegisterShopInfo(
                      nameStoreController: nameStoreController,
                      districtController: districtController,
                      groupServiceController: groupServiceController,
                      parkingFeeController: parkingFeeController,
                      phoneContactController: phoneContactController,
                      providerController: providerController,
                      specialDishController: specialDishController,
                      streetAddressController: streetAddressController,
                      streetNameController: streetNameController,
                      bloc: bloc,
                      state: state,
                    ),
                    StepRepresentativeInformation(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
