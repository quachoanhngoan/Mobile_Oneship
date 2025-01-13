import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

class StepReviewInfomation extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const StepReviewInfomation({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 50, top: 20),
          child: Column(
            children: [
              _ReviewInfo(
                title: "Khu vực kinh doanh",
                widget: SizedBox(
                  width: double.infinity,
                  child: Text(
                    bloc.state.locationBusSellected?.name.toString() ?? "",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.color054,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _ReviewInfo(
                title: "Loại hình dịch vụ",
                widget: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bloc.state.nameService?.toString() ?? "",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.color054,
                            ),
                      ),
                      const Divider(
                        color: AppColors.borderColor,
                        thickness: 0.5,
                      ),
                      Text(
                        bloc.state.isAlcohol
                            ? "Có kinh doanh rượu/ đồ uống có cồn"
                            : "Không kinh doanh rượu/ đồ uống có cồn",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: AppColors.colorA8A,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _ReviewInfo(
                title: "Thông tin quán",
                widget: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _info(
                        title: "Tên quán",
                        value: bloc.state.infomation?.nameStore ?? "",
                      ),
                      _info(
                        title: "Món đặc trưng của quán",
                        value: bloc.state.infomation?.specialDish ?? "",
                      ),
                      _info(
                        title: "Tên đường",
                        value: bloc.state.infomation?.streetName ?? "",
                      ),
                      _info(
                        title: "Số điện thoại liên hệ",
                        value: bloc.state.infomation?.formatPhone() ?? "",
                      ),
                      _info(
                        title: "Nhóm dịch vụ",
                        value: bloc.groupServiceController.text,
                      ),
                      _info(
                        title: "Tỉnh/ Thành phố",
                        value: bloc.state.infomation?.provinces ?? "",
                      ),
                      _info(
                        title: "Quận/ Huyện",
                        value: bloc.state.infomation?.districtName ?? "",
                      ),
                      _info(
                        title: "Phường/ Xã",
                        value: bloc.state.infomation?.wardName ?? "",
                      ),
                      _info(
                        title: "Số nhà, tên đường",
                        value: bloc.state.infomation?.homeAndStreet ?? "",
                      ),
                      _info(
                        title: "Phí đỗ xe",
                        value: bloc.state.infomation?.getParkingFee() ?? "",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _ReviewInfo(
                title:
                    "Thông tin người đại diện (${bloc.state.representative?.type?.name ?? ""})",
                widget: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        _info(
                          title: "Tên người đại diện",
                          value: bloc.state.representative?.name,
                        ),
                        _info(
                          title: "Tên doanh nghiệp",
                          value: bloc.state.representative?.businessName,
                        ),
                        _info(
                          title: "Địa chỉ",
                          value: bloc.state.representative?.address,
                        ),
                        _info(
                          title: "Số điện thoại",
                          value: bloc.state.representative?.phone,
                        ),
                        _info(
                          title: "Số điện thoại khác",
                          value: bloc.state.representative?.otherPhone,
                        ),
                        _info(
                          title: "Email",
                          value: bloc.state.representative?.email,
                        ),
                        // _info(
                        //   title: "Mã số thuế cá nhân",
                        //   value: bloc.state.representative?.taxCode,
                        // ),
                        _info(
                          title: "Mã số thuế",
                          value: bloc.state.representative?.taxCode,
                        ),
                        _info(
                          title: "Số CMND/CCCD/Hộ chiếu",
                          value: bloc.state.representative?.identityCard,
                        ),
                        _info(
                          title: "Ngày cấp",
                          value: bloc.state.representative?.formatDate(),
                        ),
                        _info(
                          title: "Nơi cấp",
                          value: bloc.state.representative?.identityCardPlace,
                        ),
                        Builder(builder: (context) {
                          if (bloc.state.representative
                                  ?.identityCardFrontImageId ==
                              null) {
                            return const SizedBox();
                          }
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 160,
                                    child: Text(
                                      "Ảnh chụp CMND/CCCD/Hộ chiếu",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.colorC5C,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 70,
                                        child: NetworkImageWithLoader(
                                          bloc.state.representative
                                                  ?.identityCardFrontImageId ??
                                              "",
                                          isBaseUrl: true,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 70,
                                        child: NetworkImageWithLoader(
                                          bloc.state.representative
                                                  ?.identityCardBackImageId ??
                                              "",
                                          isBaseUrl: true,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const _Space(),
                            ],
                          );
                        }),
                        Builder(builder: (context) {
                          if (bloc.state.representative
                                  ?.businessLicenseImageId ==
                              null) {
                            return const SizedBox();
                          }
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Ảnh chụp giấy phép kinh doanh",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.colorC5C,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 70,
                                    child: NetworkImageWithLoader(
                                      bloc.state.representative
                                              ?.businessLicenseImageId ??
                                          "",
                                      isBaseUrl: true,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              const _Space(),
                            ],
                          );
                        }),
                        Builder(builder: (context) {
                          if (bloc.state.representative?.relatedImageId ==
                              null) {
                            return const SizedBox();
                          }
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Ảnh chụp giấy tờ khác",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.colorC5C,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 70,
                                    child: NetworkImageWithLoader(
                                      bloc.state.representative
                                              ?.relatedImageId ??
                                          "",
                                      isBaseUrl: true,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              const _Space(),
                            ],
                          );
                        }),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              _ReviewInfo(
                title: "Thông tin ngân hàng",
                widget: SizedBox(
                  width: double.infinity,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _info(
                          title: "Ngân hàng",
                          value: bloc.selectBankController.text,
                        ),
                        _info(
                          title: "Chi nhánh",
                          value: bloc.selectBankBranchController.text,
                        ),
                        _info(
                          title: "Số tài khoản",
                          value: bloc.state.bankRequest?.bankAccountNumber,
                        ),
                        _info(
                          title: "Chủ tài khoản",
                          value: bloc.state.bankRequest?.bankAccountName,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _ReviewInfo(
                title: "Hình ảnh quán",
                widget: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ảnh đại diện",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.colorC5C,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 90,
                            child: NetworkImageWithLoader(
                              bloc.state.storeAvatarId ?? "",
                              isBaseUrl: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const _Space(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ảnh bìa",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.colorC5C,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 90,
                            child: NetworkImageWithLoader(
                              bloc.state.storeCoverId ?? "",
                              isBaseUrl: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const _Space(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ảnh mặt tiền",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.colorC5C,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 90,
                            child: NetworkImageWithLoader(
                              bloc.state.storeFrontId ?? "",
                              isBaseUrl: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const _Space(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ảnh thực đơn",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.colorC5C,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 90,
                            child: NetworkImageWithLoader(
                              bloc.state.storeMenuId ?? "",
                              isBaseUrl: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info({
    required String title,
    String? value,
  }) {
    if (value == null || value.isEmpty) {
      return const SizedBox();
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 160,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.colorC5C,
                ),
              ),
            ),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.color054,
                ),
              ),
            ),
          ],
        ),
        const _Space(),
      ],
    );
  }
}

class _Space extends StatelessWidget {
  const _Space({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.borderColor,
      thickness: 0.5,
      height: 20,
    );
  }
}

class _ReviewInfo extends StatelessWidget {
  final String title;
  final Widget widget;
  const _ReviewInfo({required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xff2F2E2E),
              ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget,
        ),
      ],
    );
  }
}
