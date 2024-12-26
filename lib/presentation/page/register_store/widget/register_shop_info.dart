import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/district_model.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';

import '../../../data/model/register_store/provinces_model.dart';

class RegisterShopInfo extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const RegisterShopInfo({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const VSpacing(spacing: 20),
                AppTextFormField(
                  hintText: "Nhập tên cửa hàng",
                  controller: bloc.nameStoreController,
                  onChanged: (value) {
                    bloc.setInfomatinoStore(state.infomation?.copyWith(
                      nameStore: value,
                    ));
                  },
                  isRequired: true,
                ),
                const VSpacing(spacing: 16),
                AppTextFormField(
                  controller: bloc.specialDishController,
                  hintText: "Nhập món đặc trưng của quán",
                  onChanged: (p0) {
                    bloc.setInfomatinoStore(state.infomation?.copyWith(
                      specialDish: p0,
                    ));
                  },
                  isRequired: true,
                ),
                const VSpacing(spacing: 16),
                AppTextFormField(
                  isRequired: false,
                  hintText: "Nhập tên đường",
                  controller: bloc.streetNameController,
                  onChanged: (value) {
                    bloc.setInfomatinoStore(state.infomation?.copyWith(
                      streetName: value,
                    ));
                  },
                ),
                const VSpacing(spacing: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  color: AppColors.background,
                  child: Text(
                    "Tên quán nên được thứ tự: Tên quán - Món đặc trưng của quán - Tên đường. (VD: Hương Quê - Bún Bò Huế - Nguyễn Văn Linh)",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                const VSpacing(spacing: 8),
                AppTextFormField(
                    isRequired: true,
                    hintText: "Số điện thoại liên hệ",
                    controller: bloc.phoneContactController,
                    onChanged: (value) {
                      bloc.validatePhone(value);
                      bloc.setInfomatinoStore(state.infomation?.copyWith(
                        phoneNumber: value,
                      ));
                    },
                    suffix: IconButton(
                        onPressed: () {
                          bloc.phoneContactController.clear();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 16,
                          color: AppColors.black.withOpacity(0.6),
                        ))),
                const VSpacing(spacing: 16),
                _GroupService(
                  bloc: bloc,
                ),
                const VSpacing(spacing: 16),
                _ProvicesWidget(
                  bloc: bloc,
                ),
                const VSpacing(spacing: 16),
                _DistrictWardWidget(
                  onClear: () {
                    bloc.districtController.clear();
                    bloc.streetAddressController.clear();
                    bloc.wardController.clear();
                    bloc.setInfomatinoStore(
                      state.infomation?.copyWith(
                        district: 0,
                        ward: 0,
                        streetName: '',
                        homeAndStreet: '',
                      ),
                    );
                  },
                  itemChange: (district) {
                    bloc.changeDistrict(district.id!);
                    bloc.setInfomatinoStore(
                      state.infomation?.copyWith(
                        district: district.id,
                        ward: 0,
                      ),
                    );
                    bloc.wardController.clear();
                  },
                  title: "Nhập quận/huyện",
                  controller: bloc.districtController,
                  listDistrict: state.listDistrict,
                ),
                const VSpacing(spacing: 16),
                _DistrictWardWidget(
                  onClear: () {
                    bloc.streetAddressController.clear();
                    bloc.wardController.clear();
                    bloc.setInfomatinoStore(
                      state.infomation?.copyWith(
                        ward: 0,
                        homeAndStreet: '',
                      ),
                    );
                  },
                  itemChange: (value) {
                    bloc.setInfomatinoStore(
                      state.infomation?.copyWith(ward: value.id),
                    );
                  },
                  title: "Nhập phường/xã",
                  controller: bloc.wardController,
                  listDistrict: state.listWard,
                ),
                const VSpacing(spacing: 16),
                AppTextFormField(
                  isRequired: true,
                  hintText: "Nhập số nhà và đường/Phố",
                  controller: bloc.streetAddressController,
                  onChanged: (value) {
                    bloc.setInfomatinoStore(state.infomation?.copyWith(
                      homeAndStreet: value,
                    ));
                  },
                ),
                const VSpacing(spacing: 16),
                AppTextFormField(
                  hintText: "Nhập phí gửi xe",
                  controller: bloc.parkingFeeController,
                  onChanged: (value) {
                    bloc.setInfomatinoStore(state.infomation?.copyWith(
                      parkingFee: value,
                    ));
                  },
                  isRequired: false,
                ),
                const VSpacing(spacing: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DistrictWardWidget extends StatefulWidget {
  final TextEditingController controller;
  final List<DistrictModel> listDistrict;
  final String title;
  final Function(DistrictModel) itemChange;
  final Function onClear;
  const _DistrictWardWidget(
      {required this.controller,
      required this.listDistrict,
      required this.title,
      required this.itemChange,
      required this.onClear});

  @override
  State<_DistrictWardWidget> createState() => _DistrictWardWidgetState();
}

class _DistrictWardWidgetState extends State<_DistrictWardWidget> {
  @override
  Widget build(BuildContext context) {
    return AppTextFormFieldSelect(
      controller: widget.controller,
      enabled: false,
      isRequired: true,
      hintText: widget.title,
      onChanged: (value) {},
      onTap: () {
        if (widget.listDistrict.isNotEmpty) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: AppColors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.listDistrict.length,
                        itemBuilder: (context, index) {
                          final item = widget.listDistrict[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.itemChange(item);
                                widget.controller.text = item.name ?? "";
                                Get.back();
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(item.name ?? ""),
                                ),
                                index != widget.listDistrict.length - 1
                                    ? const Divider(
                                        color: AppColors.backgroundGrey,
                                      )
                                    : Container()
                              ],
                            ),
                          );
                        }),
                  ),
                );
              });
        }
      },
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.onClear();
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 16,
                    color: AppColors.black.withOpacity(0.6),
                  ))
              : Container(),
          const Icon(Icons.expand_more, color: AppColors.color2B3, size: 24),
        ],
      ),
    );
  }
}

class _ProvicesWidget extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const _ProvicesWidget({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormFieldSelect(
      isRequired: true,
      controller: bloc.providerController,
      enabled: false,
      hintText: "Nhập tỉnh/thành phố",
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: AppColors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.white),
                  height: 500,
                  child: ListView.builder(
                      itemCount: bloc.state.listProvinces.length,
                      itemBuilder: (context, index) {
                        final item = bloc.state.listProvinces[index];
                        return GestureDetector(
                          onTap: () {
                            bloc.providerController.text = item.name ?? "";
                            bloc.districtController.clear();
                            bloc.streetAddressController.clear();
                            bloc.wardController.clear();
                            bloc.changeProvices(item.id!);
                            bloc.setInfomatinoStore(
                              bloc.state.infomation?.copyWith(
                                ward: 0,
                                district: 0,
                                streetName: '',
                              ),
                            );
                            Get.back();
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(item.name ?? ""),
                              ),
                              index != bloc.state.listProvinces.length - 1
                                  ? const Divider(
                                      color: AppColors.backgroundGrey,
                                    )
                                  : Container()
                            ],
                          ),
                        );
                      }),
                ),
              );
            });
      },
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          bloc.providerController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    bloc.providerController.clear();
                    bloc.districtController.clear();
                    bloc.streetAddressController.clear();
                    bloc.wardController.clear();
                    bloc.setInfomatinoStore(bloc.state.infomation?.copyWith(
                      district: 0,
                      ward: 0,
                      streetName: '',
                      homeAndStreet: '',
                    ));
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 16,
                    color: AppColors.black.withOpacity(0.6),
                  ))
              : Container(),
          const Icon(Icons.expand_more, color: AppColors.color2B3, size: 24),
        ],
      ),
    );
  }
}

class _GroupService extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const _GroupService({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
      bloc: bloc,
      builder: (context, state) {
        return AppTextFormFieldSelect(
          controller: bloc.groupServiceController,
          enabled: false,
          hintText: "Nhóm dịch vụ",
          onChanged: (value) {},
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: AppColors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.white),
                      height: 500,
                      child: ListView.builder(
                          itemCount: state.listGroupService.length,
                          itemBuilder: (context, index) {
                            final item = state.listGroupService[index];
                            return GestureDetector(
                              onTap: () {
                                bloc.groupServiceController.text =
                                    item.name ?? "";
                                Get.back();

                                bloc.setInfomatinoStore(
                                    bloc.state.infomation?.copyWith(
                                  groupServiceID: item.id,
                                  groupServiceName: item.name,
                                ));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(item.name ?? ""),
                                  ),
                                  index != state.listGroupService.length - 1
                                      ? const Divider(
                                          color: AppColors.backgroundGrey,
                                        )
                                      : Container()
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                });
          },
          suffixIcon: Row(
            // alignment: Alignment.centerRight,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              bloc.groupServiceController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        bloc.groupServiceController.clear();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 16,
                        color: AppColors.black.withOpacity(0.6),
                      ))
                  : Container(),
              const Icon(Icons.expand_more,
                  color: AppColors.color2B3, size: 24),
            ],
          ),
          isRequired: true,
        );
      },
    );
  }
}
