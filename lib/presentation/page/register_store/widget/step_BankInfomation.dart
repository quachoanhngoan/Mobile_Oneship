import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/bank.model.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_request.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';

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
                  DropdownButton2(
                    items: state.banks.map<DropdownMenuItem<BankM>>((value) {
                      return DropdownMenuItem<BankM>(
                          value: value,
                          child: Text(
                            value.name ?? "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ));
                    }).toList(),
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    onChanged: (value) {
                      if (value != null) {
                        bloc.setBankRequest(state.bankRequest?.copyWith(
                          bankId: value.id.toString(),
                          bankName: value.name,
                        ));
                      }
                    },
                    iconStyleData: const IconStyleData(
                        icon: Icon(Icons.expand_more,
                            color: AppColors.color2B3, size: 20)),
                    buttonStyleData: const ButtonStyleData(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border(
                            bottom: BorderSide(
                                color: AppColors.borderColor, width: 1),
                          )),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.color2B3, width: 1),
                      ),
                      maxHeight: 400,
                      width: double.infinity,
                    ),
                    hint: Container(
                      color: AppColors.transparent,
                      child: RichText(
                        text: TextSpan(
                          text: state.bankRequest?.bankName ?? "Chọn ngân hàng",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: state.bankRequest?.bankName != null
                                      ? AppColors.textColor
                                      : AppColors.color2B3),
                          children: [
                            if (state.bankRequest?.bankName == null)
                              const TextSpan(
                                text: "*",
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton2(
                    items: state.branchBanks
                        .map<DropdownMenuItem<BranchBankM>>((value) {
                      return DropdownMenuItem<BranchBankM>(
                          value: value,
                          child: Text(
                            value.name ?? "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ));
                    }).toList(),
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    onChanged: (value) {
                      if (value != null) {
                        bloc.setBankRequest(state.bankRequest?.copyWith(
                          bankBranchId: value.id.toString(),
                          bankBranchName: value.name,
                        ));
                      }
                    },
                    iconStyleData: const IconStyleData(
                        icon: Icon(Icons.expand_more,
                            color: AppColors.color2B3, size: 20)),
                    buttonStyleData: const ButtonStyleData(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border(
                            bottom: BorderSide(
                                color: AppColors.borderColor, width: 1),
                          )),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8)),
                      maxHeight: 400,
                      width: double.infinity,
                    ),
                    hint: Container(
                      color: AppColors.transparent,
                      child: RichText(
                        text: TextSpan(
                          text: state.bankRequest?.bankBranchName ??
                              "Chọn chi nhánh",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: state.bankRequest?.bankName != null
                                      ? AppColors.textColor
                                      : AppColors.color2B3),
                          children: [
                            if (state.bankRequest?.bankBranchName == null)
                              const TextSpan(
                                text: "*",
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
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
