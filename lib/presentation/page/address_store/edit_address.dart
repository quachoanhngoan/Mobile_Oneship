import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/search.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/address.model.dart';
import 'package:oneship_merchant_app/presentation/page/address_store/bloc/edit_address_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/address_store/search_address.dart';
import 'package:oneship_merchant_app/presentation/page/address_store/text_form_field.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';

class EditAddressPage extends StatefulWidget {
  final AddressStoreM? address;
  const EditAddressPage({
    super.key,
    this.address,
  });

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late EditAddressBloc _editAddressBloc;
  String? newAddress;
  late final TextEditingController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.address?.address);
    _editAddressBloc = injector.get<EditAddressBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAddressBloc, EditAddressState>(
      bloc: _editAddressBloc,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppButton(
                isLoading: state.updateAddressStatus.isLoading,
                isEnable: true,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _editAddressBloc.updateAddress(
                    widget.address?.type ?? "",
                  );
                },
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                borderSide: const BorderSide(color: AppColors.primary),
                text: "Lưu",
              ),
            ),
          ),
          backgroundColor: const Color(0xffF5F5F5),
          appBar: const AppBarAuth(
            title: "Chỉnh sửa địa chỉ nhận hàng",
            isShowHelpButton: false,
          ),
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FormEditAddress(
                  title: widget.address?.store?.name ?? "",
                ),
                const SizedBox(height: 10),
                EditAddressFormField(
                  isRequired: false,
                  enabled: false,
                  filled: true,
                  hintText: 'Số điện thoại',
                  initialValue: widget.address?.store?.phoneNumber ?? "",
                ),
                const SizedBox(height: 10),
                EditAddressFormField(
                  onTap: () async {
                    final result =
                        await Get.to(() => const SearchAddressPage());
                    if (result != null) {
                      final feature = result as Features;

                      _editAddressBloc.setRequestUpdateAddress(
                          state.requestUpdateAddress.copyWith(
                        address: feature.text,
                        lat: feature.center?[0],
                        lng: feature.center?[1],
                      ));
                      print(feature.text);
                      _controller.text = feature.text ?? "";
                    }
                  },
                  suffix: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.color373,
                    size: 12,
                  ),
                  isRequired: false,
                  enabled: false,
                  hintText: 'Địa chỉ',
                  controller: _controller,
                ),
                const SizedBox(height: 10),
                EditAddressFormField(
                  isRequired: false,
                  enabled: true,
                  hintText: 'Toà nhà',
                  initialValue: widget.address?.building ?? "",
                  onChanged: (p0) {
                    _editAddressBloc.setRequestUpdateAddress(
                        state.requestUpdateAddress.copyWith(building: p0));
                  },
                ),
                const SizedBox(height: 10),
                EditAddressFormField(
                  isRequired: false,
                  enabled: true,
                  hintText: 'Cổng',
                  initialValue: widget.address?.gate ?? "",
                  onChanged: (p0) {
                    _editAddressBloc.setRequestUpdateAddress(
                        state.requestUpdateAddress.copyWith(gate: p0));
                  },
                ),
                const SizedBox(height: 10),
                EditAddressFormField(
                  isRequired: false,
                  enabled: true,
                  hintText: 'Ghi chú cho tài xế',
                  initialValue: widget.address?.note ?? "",
                  onChanged: (p0) {
                    // _editAddressBloc.setRequestUpdateAddress(
                    //     state.requestUpdateAddress.copyWith(note: p0));
                  },
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
                    widget.address?.getNameAddresss() ?? "",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color(0xffE15D33),
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FormEditAddress extends StatelessWidget {
  final String title;
  const _FormEditAddress({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
      },
      child: TextFormField(
        enabled: false,
        initialValue: title,
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
