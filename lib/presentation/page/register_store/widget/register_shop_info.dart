import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/district_model.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';

import '../../../data/model/register_store/group_service_model.dart';
import '../../../data/model/register_store/provinces_model.dart';
import '../../register/register_page.dart';

class RegisterShopInfo extends StatefulWidget {
  final TextEditingController nameStoreController;
  final TextEditingController specialDishController;
  final TextEditingController streetNameController;
  final TextEditingController phoneContactController;
  final TextEditingController groupServiceController;
  final TextEditingController providerController;
  final TextEditingController districtController;
  final TextEditingController wardController;
  final TextEditingController streetAddressController;
  final TextEditingController parkingFeeController;
  final RegisterStoreCubit bloc;
  final RegisterStoreState state;
  const RegisterShopInfo(
      {super.key,
      required this.nameStoreController,
      required this.districtController,
      required this.groupServiceController,
      required this.parkingFeeController,
      required this.phoneContactController,
      required this.providerController,
      required this.specialDishController,
      required this.streetAddressController,
      required this.streetNameController,
      required this.wardController,
      required this.bloc,
      required this.state});

  @override
  State<RegisterShopInfo> createState() => _RegisterShopInfoState();
}

class _RegisterShopInfoState extends State<RegisterShopInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const VSpacing(spacing: 20),
            TextFieldPassRegister(
              controller: widget.nameStoreController,
              hintText: "Nhập tên cửa hàng",
              iSHintTextVisible: widget.state.showHintNameStore,
              onChange: (value) {
                widget.bloc.nameStoreVerify(value);
                enableContinue();
              },
              horizontalPadding: 0,
            ),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
                controller: widget.specialDishController,
                hintText: "Nhập món đặc trưng của quán",
                iSHintTextVisible:
                    !widget.specialDishController.text.isNotNullOrEmpty,
                onChange: (value) {
                  setState(() {});
                },
                isStarRed: false,
                horizontalPadding: 0),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
                controller: widget.streetNameController,
                hintText: "Nhập tên đường",
                iSHintTextVisible:
                    !widget.streetNameController.text.isNotNullOrEmpty,
                onChange: (value) {
                  setState(() {});
                },
                isStarRed: false,
                horizontalPadding: 0),
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
            TextFieldPassRegister(
                controller: widget.phoneContactController,
                hintText: "Số điện thoại liên hệ",
                iSHintTextVisible:
                    !widget.phoneContactController.text.isNotNullOrEmpty,
                onChange: (value) {
                  widget.bloc.validatePhone(value);
                  enableContinue();
                },
                errorText: widget.state.errorPhoneContact,
                isNumber: true,
                horizontalPadding: 0,
                suffix: IconButton(
                    onPressed: () {
                      widget.phoneContactController.clear();
                      widget.bloc.validatePhone(null);
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 16,
                      color: AppColors.black.withOpacity(0.6),
                    ))),
            const VSpacing(spacing: 16),
            _GroupService(
              controller: widget.groupServiceController,
              listGroupService: widget.state.listGroupService,
              onChange: () {
                enableContinue();
              },
            ),
            const VSpacing(spacing: 16),
            _ProvicesWidget(
                onClear: () {
                  widget.providerController.clear();
                  widget.districtController.clear();
                  widget.streetAddressController.clear();
                  widget.wardController.clear();
                  enableContinue();
                },
                providerChange: (provices) {
                  widget.districtController.clear();
                  widget.streetAddressController.clear();
                  widget.wardController.clear();
                  widget.bloc.changeProvices(provices);
                  enableContinue();
                },
                controller: widget.providerController,
                listProvinces: widget.state.listProvinces),
            const VSpacing(spacing: 16),
            _DistrictWardWidget(
              onClear: () {
                widget.districtController.clear();
                widget.streetAddressController.clear();
                widget.wardController.clear();
                enableContinue();
              },
              itemChange: (district) {
                widget.bloc.changeDistrict(district);
                enableContinue();
              },
              title: "Nhập quận/huyện",
              controller: widget.districtController,
              listDistrict: widget.state.listDistrict,
            ),
            const VSpacing(spacing: 16),
            _DistrictWardWidget(
              onClear: () {
                widget.streetAddressController.clear();
                widget.wardController.clear();
                enableContinue();
              },
              itemChange: (value) {
                enableContinue();
              },
              title: "Nhập phường/xã",
              controller: widget.wardController,
              listDistrict: widget.state.listWard,
            ),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
              controller: widget.streetAddressController,
              hintText: "Nhập số nhà và đường/Phố",
              iSHintTextVisible:
                  !widget.streetAddressController.text.isNotNullOrEmpty,
              onChange: (value) {
                enableContinue();
              },
              horizontalPadding: 0,
            ),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
              controller: widget.parkingFeeController,
              hintText: "Nhập phí gửi xe",
              iSHintTextVisible:
                  !widget.parkingFeeController.text.isNotNullOrEmpty,
              onChange: (value) {
                setState(() {});
              },
              horizontalPadding: 0,
              isStarRed: false,
            ),
            const VSpacing(spacing: 20),
          ],
        ),
      ),
    );
  }

  void enableContinue() {
    widget.bloc.verifyContinueInfoStore(
        nameStore: widget.nameStoreController.text,
        provinces: widget.providerController.text,
        phoneNumber: widget.phoneContactController.text,
        groupService: widget.groupServiceController.text,
        district: widget.districtController.text,
        ward: widget.wardController.text,
        homeAndStreet: widget.streetAddressController.text);
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
    return TextFieldPassRegister(
      controller: widget.controller,
      readOnly: true,
      hintText: widget.title,
      iSHintTextVisible: !widget.controller.text.isNotNullOrEmpty,
      onChange: (value) {},
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
      horizontalPadding: 0,
      specialPrefix: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          widget.controller.text.isNotNullOrEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                      onPressed: () {
                        widget.onClear();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 16,
                        color: AppColors.black.withOpacity(0.6),
                      )),
                )
              : Container(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.expand_more,
                color: AppColors.color2B3, size: 24),
          )
        ],
      ),
    );
  }
}

class _ProvicesWidget extends StatefulWidget {
  final TextEditingController controller;
  final List<ProvinceModel> listProvinces;
  final Function(ProvinceModel) providerChange;
  final Function onClear;
  const _ProvicesWidget(
      {required this.controller,
      required this.listProvinces,
      required this.providerChange,
      required this.onClear});

  @override
  State<_ProvicesWidget> createState() => __ProvicesWidgetState();
}

class __ProvicesWidgetState extends State<_ProvicesWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFieldPassRegister(
      controller: widget.controller,
      readOnly: true,
      hintText: "Nhập tỉnh/thành phố",
      iSHintTextVisible: !widget.controller.text.isNotNullOrEmpty,
      onChange: (value) {},
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
                      itemCount: widget.listProvinces.length,
                      itemBuilder: (context, index) {
                        final item = widget.listProvinces[index];
                        return GestureDetector(
                          onTap: () {
                            widget.providerChange(item);
                            widget.controller.text = item.name ?? "";
                            Get.back();
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(item.name ?? ""),
                              ),
                              index != widget.listProvinces.length - 1
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
      horizontalPadding: 0,
      specialPrefix: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          widget.controller.text.isNotNullOrEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                      onPressed: () {
                        widget.onClear();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 16,
                        color: AppColors.black.withOpacity(0.6),
                      )),
                )
              : Container(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.expand_more,
                color: AppColors.color2B3, size: 24),
          )
        ],
      ),
    );
  }
}

class _GroupService extends StatefulWidget {
  final TextEditingController controller;
  final List<GroupServiceModel> listGroupService;
  final Function onChange;
  const _GroupService(
      {required this.controller,
      required this.listGroupService,
      required this.onChange});

  @override
  State<_GroupService> createState() => _GroupServiceState();
}

class _GroupServiceState extends State<_GroupService> {
  @override
  Widget build(BuildContext context) {
    return TextFieldPassRegister(
      controller: widget.controller,
      readOnly: true,
      hintText: "Nhóm dịch vụ",
      iSHintTextVisible: !widget.controller.text.isNotNullOrEmpty,
      onChange: (value) {
        widget.onChange();
      },
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
                      itemCount: widget.listGroupService.length,
                      itemBuilder: (context, index) {
                        final item = widget.listGroupService[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.controller.text = item.name ?? "";
                              Get.back();
                            });
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(item.name ?? ""),
                              ),
                              index != widget.listGroupService.length - 1
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
      horizontalPadding: 0,
      specialPrefix: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          widget.controller.text.isNotNullOrEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.controller.clear();
                        });
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 16,
                        color: AppColors.black.withOpacity(0.6),
                      )),
                )
              : Container(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.expand_more,
                color: AppColors.color2B3, size: 24),
          )
        ],
      ),
    );
  }
}
