import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';

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
                offset: const Offset(0, -4), // changes position of shadow
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
              Get.toNamed('/registerpage');
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
              TabBar(
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
                    child: const Text(
                      "Quản lí quán",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(12),
                    child: const Text(
                      "Đăng ký quán",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                        // vertical: 12,
                        horizontal: 16,
                      ),
                      // ignore: prefer_const_constructors
                      child: BlocBuilder<StoreCubit, StoreState>(
                        builder: (context, state) {
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
                            itemCount: state.stores.length,
                            itemBuilder: (context, index) {
                              final item = state.stores[index];
                              return StoreItem(
                                data: item,
                              );
                            },
                          );
                        },
                      )),
                  Container(
                    child: const Center(
                      child: Text('Store Page'),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}

class StoreItem extends StatelessWidget {
  final StoreModel data;
  const StoreItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor2, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 68.sp,
                width: 68.sp,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://admin-dev.oneship.com.vn/api/v1/uploads/${data.storeFrontId}',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                child: SizedBox(
                  height: 68.sp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? '',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      StoreStatusWidget(
                        status: data.status ?? '',
                      ),
                      //dash border
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.sp,
          ),
          const DottedLine(
            dashColor: AppColors.borderColor2,
            dashGapLength: 4,
            dashLength: 4,
            lineThickness: 1,
          ),
          SizedBox(
            height: 8.sp,
          ),
          Visibility(
            visible: !false,
            replacement: SizedBox(
              width: Get.width,
              child: Text(
                'Xem chi tiết',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.primary,
                    ),
              ),
            ),
            child: Text(
              data.address ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class StoreStatusWidget extends StatelessWidget {
  final String status;
  const StoreStatusWidget({
    super.key,
    required this.status,
  });

  String getTextFromStatus() {
    switch (status) {
      case 'active':
        return 'Đang hoạt động';
      case 'inactive':
        return 'Ngừng hoạt động';
      case 'pending':
        return 'Chờ duyệt';
      case 'rejected':
        return 'Từ chối';
      case "updating":
        return 'Đang cập nhật';
      default:
        return 'Không xác định';
    }
  }

  Color getColorFromStatus() {
    switch (status) {
      case 'active':
        return AppColors.primary;
      case 'inactive':
        return AppColors.textGrayBold;
      case 'pending':
        return const Color(0xffF449CF);
      case 'rejected':
        return const Color(0xffDB6844);
      case "updating":
        return const Color(0xff1C5FC3);
      default:
        return AppColors.textColor;
    }
  }

  Color getColorBgFromStatus() {
    switch (status) {
      case 'active':
        return const Color(0xffEDFCF2);
      case 'inactive':
        return const Color(0xffE8E8E8);
      case 'pending':
        return const Color(0xffF8E4FF);
      case 'rejected':
        return const Color(0xffFDEAE4);
      case "updating":
        return const Color(0xffDDF4FF);
      default:
        return AppColors.textColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            getTextFromStatus(),
            style: TextStyle(
              color: getColorFromStatus(),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
