import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/register_location_service.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/register_type_service.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_BankInfomation.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_RepresentativeInformation.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_image_store.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_review_infomation.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/step_terms_conditions.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';

import 'cubit/register_store_cubit.dart';
import 'widget/register_shop_info.dart';

class RegisterStorePage extends StatefulWidget {
  final int? idStore;
  final bool isRegistered;
  const RegisterStorePage({super.key, this.idStore, this.isRegistered = false});

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  late RegisterStoreCubit bloc;

  @override
  void initState() {
    bloc = injector.get<RegisterStoreCubit>();

    bloc.idStore = widget.idStore;
    if (widget.idStore != null) {
      bloc.getStoreById(widget.idStore!, widget.isRegistered);
    }
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
        bloc: bloc,
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
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
                  child: widget.isRegistered
                      ? const SizedBox()
                      : AppButton(
                          isCheckLastPress: false,
                          isLoading: state.registerStatus.isLoading ||
                              state.status.isLoading,
                          isEnable: state.isButtonNextEnable(),
                          padding: EdgeInsets.symmetric(
                            vertical: 10.sp,
                            horizontal: 12.sp,
                          ),
                          onPressed: () {
                            bloc.registerStorePress();
                          },
                          text: "Tiếp tục",
                        ),
                ),
                appBar: widget.isRegistered
                    ? AppBarAuth(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        title: "Thông tin đăng ký",
                        isShowHelpButton: false,
                      )
                    : AppBarAuth(
                        onPressed: () {
                          bloc.setPreviousPage();
                        },
                        title: state.currentPage.title,
                        isShowHelpButton: false,
                      ),
                body: Column(
                  children: [
                    state.currentPage.index > 0 && !widget.isRegistered
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
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInCubic,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: index < state.currentPage.index
                                              ? AppColors.primary
                                              : AppColors.textGray,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    widget.isRegistered
                        ? Flexible(
                            child: StepReviewInfomation(
                              bloc: bloc,
                            ),
                          )
                        : Flexible(
                            child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: bloc.pageController,
                              children: [
                                TermsAndConditionsPage(
                                  bloc: bloc,
                                ),
                                RegisterTypeOfService(
                                  state: state,
                                  bloc: bloc,
                                ),
                                RegisterLocationOfService(
                                  bloc: bloc,
                                ),
                                RegisterShopInfo(
                                  bloc: bloc,
                                ),
                                StepRepresentativeInformation(
                                  bloc: bloc,
                                ),
                                StepBankInformation(
                                  bloc: bloc,
                                ),
                                StepImageStore(
                                  bloc: bloc,
                                ),
                                StepReviewInfomation(
                                  bloc: bloc,
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
              BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                          child: CupertinoActivityIndicator(
                        color: AppColors.primary,
                      )),
                    );
                  }
                  return Container();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
