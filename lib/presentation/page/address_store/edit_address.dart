import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/food_update_response.dart';
import 'package:oneship_merchant_app/presentation/page/address_store/app_text_form_field.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: const AppBarAuth(
        title: "Chỉnh sửa địa chỉ nhận hàng",
        isShowHelpButton: false,
      ),
      body: BlocBuilder<StoreCubit, StoreState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FormEditAddress(),
                const SizedBox(height: 10),
                const EditAddressFormField(
                  isRequired: false,
                  enabled: true,
                  hintText: 'Số điện thoại',
                  initialValue: "123123112",
                ),
                const SizedBox(height: 10),
                const EditAddressFormField(
                  isRequired: false,
                  enabled: true,
                  hintText: 'Địa chỉ',
                  initialValue: "123123112",
                ),
                const SizedBox(height: 10),
                const EditAddressFormField(
                  isRequired: false,
                  enabled: true,
                  hintText: 'Toà nhà',
                  initialValue: "123123112",
                ),
                const SizedBox(height: 10),
                const EditAddressFormField(
                  isRequired: false,
                  enabled: true,
                  hintText: 'Cổng',
                  initialValue: "123123112",
                ),
                const SizedBox(height: 10),
                const EditAddressFormField(
                  isRequired: false,
                  enabled: true,
                  hintText: 'Ghi chú cho tài xế',
                  initialValue: "",
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffE15D33),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "Nhận hàng",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color(0xffE15D33),
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FormEditAddress extends StatelessWidget {
  const _FormEditAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: TextFormField(
        initialValue: "Nguyễn Trần Hoàng Long",
        cursorHeight: 16,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
        autocorrect: false,
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: "Tên quán",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.color373,
                  ),
            ),
          ),
          isDense: false,
          filled: true,

          hintText: "Tên người nhận",
          fillColor: const Color(0xffF9FAFB),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.color373,
              ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          floatingLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.color373,
              ),

          // hintText: 'Nhập họ và tên người đại diện',
        ),
      ),
    );
  }
}
