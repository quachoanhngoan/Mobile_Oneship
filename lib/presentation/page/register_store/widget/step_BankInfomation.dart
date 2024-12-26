import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/bank.model.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';

import 'app_text_form_field.dart';

class StepBankInformation extends StatelessWidget {
  final RegisterStoreCubit bloc;

  const StepBankInformation({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
          bloc: bloc,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // DropdownButton2(
                  //   items: state.banks.map<DropdownMenuItem<BankM>>((value) {
                  //     return DropdownMenuItem<BankM>(
                  //         value: value,
                  //         child: Text(
                  //           value.name ?? "",
                  //           style: Theme.of(context).textTheme.bodySmall,
                  //         ));
                  //   }).toList(),
                  //   isExpanded: true,
                  //   underline: const SizedBox.shrink(),
                  //   onChanged: (value) {
                  //     if (value != null) {
                  //       bloc.setBankRequest(state.bankRequest?.copyWith(
                  //         bankId: value.id.toString(),
                  //         bankName: value.name,
                  //       ));
                  //     }
                  //   },
                  //   iconStyleData: const IconStyleData(
                  //       icon: Icon(Icons.expand_more,
                  //           color: AppColors.color2B3, size: 20)),
                  //   buttonStyleData: const ButtonStyleData(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //         color: AppColors.white,
                  //         border: Border(
                  //           bottom: BorderSide(
                  //               color: AppColors.borderColor, width: 1),
                  //         )),
                  //   ),
                  //   dropdownStyleData: DropdownStyleData(
                  //     decoration: BoxDecoration(
                  //       color: AppColors.white,
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(color: AppColors.color2B3, width: 1),
                  //     ),
                  //     maxHeight: 400,
                  //     width: double.infinity,
                  //   ),
                  //   hint: Container(
                  //     color: AppColors.transparent,
                  //     child: RichText(
                  //       text: TextSpan(
                  //         text: state.bankRequest?.bankName ?? "Chọn ngân hàng",
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodySmall
                  //             ?.copyWith(
                  //                 fontWeight: FontWeight.w500,
                  //                 color: state.bankRequest?.bankName != null
                  //                     ? AppColors.textColor
                  //                     : AppColors.color2B3),
                  //         children: [
                  //           if (state.bankRequest?.bankName == null)
                  //             const TextSpan(
                  //               text: "*",
                  //               style: TextStyle(
                  //                 color: AppColors.red,
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  AppTextFormFieldSelect(
                    controller: bloc.selectBankController,
                    isRequired: true,
                    enabled: false,
                    hintText: 'Nhập tên chủ tài khoản',
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: ListView.builder(
                                itemCount: state.banks.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    trailing: state.bankRequest?.bankId ==
                                            state.banks[index].id.toString()
                                        ? const Icon(
                                            Icons.check,
                                            color: AppColors.primary,
                                          )
                                        : null,
                                    title: Text(state.banks[index].name ?? ""),
                                    onTap: () {
                                      bloc.setBankRequest(
                                          state.bankRequest?.copyWith(
                                        bankId: state.banks[index].id,
                                        bankName: state.banks[index].name,
                                      ));
                                      bloc.selectBankController.text =
                                          state.banks[index].name ?? "";
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              )),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  AppTextFormFieldSelect(
                    controller: bloc.selectBankBranchController,
                    isRequired: true,
                    // initialValue: state.bankRequest?.bankName,
                    enabled: false,
                    hintText: 'Chọn chi nhánh ngân hàng',
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.5,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Builder(builder: (context) {
                                if (state.branchBanks.isEmpty) {
                                  return const Center(
                                    child: Text("Chưa có chi nhánh nào"),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: state.branchBanks.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      trailing:
                                          state.bankRequest?.bankBranchId ==
                                                  state.branchBanks[index].id
                                              ? const Icon(
                                                  Icons.check,
                                                  color: AppColors.primary,
                                                )
                                              : null,
                                      title: Text(
                                          state.branchBanks[index].name ?? ""),
                                      onTap: () {
                                        bloc.setBankRequest(
                                            state.bankRequest?.copyWith(
                                          bankBranchId:
                                              state.branchBanks[index].id,
                                          bankBranchName:
                                              state.branchBanks[index].name,
                                        ));
                                        bloc.selectBankBranchController.text =
                                            state.branchBanks[index].name ?? "";
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              })),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  AppTextFormField(
                    isRequired: true,
                    initialValue: state.bankRequest?.bankAccountName,
                    hintText: 'Nhập tên chủ tài khoản',
                    onChanged: (p0) {
                      bloc.setBankRequest(
                          state.bankRequest?.copyWith(bankAccountName: p0));
                    },
                  ),
                  const SizedBox(height: 8),
                  AppTextFormField(
                    isRequired: true,
                    initialValue: state.bankRequest?.bankAccountNumber,
                    hintText: 'Nhập số tài khoản',
                    onChanged: (p0) {
                      bloc.setBankRequest(
                          state.bankRequest?.copyWith(bankAccountNumber: p0));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
