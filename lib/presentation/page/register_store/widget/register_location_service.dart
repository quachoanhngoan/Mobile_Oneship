import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';

import '../../../data/model/register_store/provinces_model.dart';

class RegisterLocationOfService extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const RegisterLocationOfService({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              const VSpacing(spacing: 30),
              DropdownButton2(
                items: state.listProvinces
                    .map<DropdownMenuItem<ProvinceModel>>((value) {
                  return DropdownMenuItem<ProvinceModel>(
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
                    bloc.sellectLocationBussiness(value);
                  }
                },
                iconStyleData: const IconStyleData(
                    icon: Icon(Icons.expand_more,
                        color: AppColors.color2B3, size: 20)),
                buttonStyleData: const ButtonStyleData(
                  width: double.infinity,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8)),
                  maxHeight: 400,
                  width: sizeScreen.width - 32,
                ),
                hint: Container(
                  color: AppColors.transparent,
                  child: Text(
                    state.locationBusSellected?.name ?? "Chọn khu vực",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: state.locationBusSellected == null
                            ? AppColors.color2B3
                            : AppColors.textColor),
                  ),
                ),
              ),
              Divider(color: AppColors.black.withOpacity(0.3)),
              const VSpacing(spacing: 12),
              Container(
                padding: const EdgeInsets.all(12),
                color: AppColors.background,
                child: Text(
                  "Bạn chỉ có thể tạo quán trên Goo+ nếu quán nằm trong khu vực hoạt động của Goo+. Vui lòng chọn thành phố theo danh sách bên dưới và xác nhận.",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
