import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/routes/app_router.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/store/widget/store_item.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    context.read<StoreCubit>().getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            isEnable: true,
            padding: EdgeInsets.symmetric(
              vertical: 12.sp,
              horizontal: 16.sp,
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.registerStorePage);
            },
            text: 'Đăng ký quán',
          ),
        ),
        appBar: const AppBarAuth(
          title: 'Quản lí quán',
          isShowHelpButton: false,
        ),
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  return TabBar(
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    labelColor: AppColors.primary,
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelColor: AppColors.textGray,
                    unselectedLabelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorColor: AppColors.primary,
                    indicator: const UnderlineTabIndicator(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          width: 3.0,
                          color: AppColors.primary,
                        ),
                        insets: EdgeInsets.zero),
                    tabs: <Widget>[
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Quản lí quán "
                          "(${state.getStoresApproveCount})",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Đăng ký quán"
                          " (${state.getStoresDontApproveCount})",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Flexible(
                child: TabBarView(children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: BlocBuilder<StoreCubit, StoreState>(
                        builder: (context, state) {
                          if (state.status.isLoading) {
                            return const CupertinoActivityIndicator();
                          }
                          if (state.getStoresApproveCount == 0) {
                            return Container(
                              alignment: Alignment.center, // use aligment
                              child: Image.asset(
                                AppAssets.imagesStoresEmpty,
                                height: 180,
                                width: 180,
                                filterQuality: FilterQuality.medium,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 12,
                            ),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              bottom: 100,
                              top: 12,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.getStoresApproveCount,
                            itemBuilder: (context, index) {
                              final item = state.getStoresApprove[index];
                              return StoreItem(
                                data: item,
                              );
                            },
                          );
                        },
                      )),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: BlocBuilder<StoreCubit, StoreState>(
                        builder: (context, state) {
                          if (state.status.isLoading) {
                            return const CupertinoActivityIndicator();
                          }
                          if (state.getStoresDontApproveCount == 0) {
                            return Container(
                              alignment: Alignment.center, // use aligment
                              child: Image.asset(
                                AppAssets.imagesStoresEmpty,
                                filterQuality: FilterQuality.medium,
                                height: 180,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 12,
                            ),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              bottom: 100,
                              top: 12,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.getStoresDontApproveCount,
                            itemBuilder: (context, index) {
                              final item = state.getStoresDontApprove[index];
                              return StoreItem(
                                data: item,
                              );
                            },
                          );
                        },
                      )),
                ]),
              ),
            ],
          ),
        ));
  }
}

class StoreStatusWidget extends StatelessWidget {
  final String status;
  final String approvalStatus;
  final String? reason;
  const StoreStatusWidget({
    super.key,
    required this.status,
    required this.approvalStatus,
    this.reason,
  });

  String getTextFromStatusAndApprovalStatus() {
    if (status == 'active' && approvalStatus == 'approved') {
      return 'Đang hoạt động';
    }
    if (status == 'inactive' && approvalStatus == 'approved') {
      return 'Ngừng hoạt động';
    }
    switch (approvalStatus) {
      case 'pending':
        return 'Chờ duyệt';
      case 'rejected':
        return 'Đã từ chối';
      case 'draft':
        return 'Đang cập nhật';
      default:
        return 'Đang cập nhật';
    }
  }

  Color getColorFromStatus() {
    if (status == 'active' && approvalStatus == 'approved') {
      return AppColors.primary;
    }
    if (status == 'inactive' && approvalStatus == 'approved') {
      return AppColors.textGrayBold;
    }
    switch (approvalStatus) {
      case 'pending':
        return const Color(0xffF449CF);
      case 'rejected':
        return const Color(0xffDB6844);
      case 'draft':
        return const Color(0xff1C5FC3);
      default:
        return AppColors.textColor;
    }
  }

  Color getColorBgFromStatus() {
    if (status == 'active' && approvalStatus == 'approved') {
      return const Color(0xffEDFCF2);
    }
    if (status == 'inactive' && approvalStatus == 'approved') {
      return const Color(0xffE8E8E8);
    }

    switch (approvalStatus) {
      case 'pending':
        return const Color(0xffF8E4FF);
      case 'rejected':
        return const Color(0xffFDEAE4);
      case 'draft':
        return const Color(0xffDDF4FF);
      default:
        return AppColors.textColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: getColorBgFromStatus(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 6.sp,
                width: 6.sp,
                decoration: BoxDecoration(
                  color: getColorFromStatus(),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                getTextFromStatusAndApprovalStatus(),
                style: TextStyle(
                  color: getColorFromStatus(),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (approvalStatus == 'rejected' &&
            reason != null &&
            reason!.isNotEmpty)
          InkWell(
            onTap: () {
              dialogService.showAlertDialog(
                title: "Lý do từ chối",
                description: reason!,
                buttonTitle: 'Chỉnh sửa',
                buttonCancelTitle: 'Quay lại',
                onPressed: () {
                  Get.back();
                },
                onCancel: () {
                  Get.back();
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 12.sp,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Lý do từ chối',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
