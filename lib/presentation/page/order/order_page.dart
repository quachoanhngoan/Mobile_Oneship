import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/extensions/time_extention.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/order/cancel.model.dart';
import 'package:oneship_merchant_app/presentation/page/order/bloc/order_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/order/icon_item_order.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/info_customer.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/note_customer.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/order_revenue.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/payment_info.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/sumary_order.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderPage extends StatefulWidget {
  final int id;
  const OrderPage({super.key, required this.id});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderCubit orderCubit;
  @override
  void initState() {
    orderCubit = injector<OrderCubit>();
    orderCubit.getOrderById(widget.id);
    print('OrderPage: ${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: orderCubit,
      builder: (context, state) {
        return Stack(
          children: [
            Builder(builder: (context) {
              if (state.status.isLoading) {
                return const Scaffold(
                  body: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              if (state.order == null) {
                return const Scaffold(
                  appBar: AppBarAuth(
                    title: 'Chi tiết đơn hàng',
                    isShowBackButton: true,
                    isShowHelpButton: false,
                  ),
                  body: Center(
                    child: Text('Không tìm thấy đơn hàng'),
                  ),
                );
              }
              return Scaffold(
                appBar: const AppBarAuth(
                  title: 'Chi tiết đơn hàng',
                  isShowBackButton: true,
                  isShowHelpButton: false,
                ),
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
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Builder(builder: (context) {
                      if (state.order!.getOrderStatus()?.isPending == true) {
                        return Row(
                          children: [
                            Flexible(
                              child: AppButton(
                                isCheckLastPress: false,
                                isEnable: true,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  cancelReasonTable(orderCubit);
                                },
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                backgroundColor: Colors.white,
                                textColor: Colors.red,
                                borderSide: const BorderSide(color: Colors.red),
                                text: "Huỷ đơn",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: AppButton(
                                isCheckLastPress: false,
                                isEnable: false,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                },
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                backgroundColor: AppColors.primary,
                                textColor: const Color(0xffB4B5B7),
                                text: "Nhận đơn",
                              ),
                            ),
                          ],
                        );
                      }
                      if (state.order!.getOrderStatus()?.isConfirmed == true ||
                          state.order!.getOrderStatus()?.isDriverAccepted ==
                              true) {
                        return AppButton(
                          isCheckLastPress: false,
                          isEnable: true,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            cancelReasonTable(orderCubit);
                          },
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          backgroundColor: Colors.white,
                          textColor: Colors.red,
                          borderSide: const BorderSide(color: Colors.red),
                          text: "Huỷ đơn",
                        );
                      }
                      if (state.order!.getOrderStatus()?.isInDelivery == true) {
                        return AppButton(
                          isCheckLastPress: false,
                          isEnable: true,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Get.back();
                          },
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          backgroundColor: AppColors.primary,
                          textColor: Colors.white,
                          text: "Thông báo cho tài xế",
                        );
                      }

                      if (state.order!.getOrderStatus()?.isCancelled == true) {
                        return AppButton(
                          isCheckLastPress: false,
                          isEnable: true,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Get.back();
                          },
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          backgroundColor: AppColors.primary,
                          textColor: Colors.white,
                          text: "Quay lại",
                        );
                      }
                      if (state.order!.getOrderStatus()?.isDelivered == true) {
                        return AppButton(
                          isCheckLastPress: false,
                          isEnable: true,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => OrderRevenue(
                                  orderCubit: orderCubit,
                                ));
                          },
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          backgroundColor: AppColors.primary,
                          textColor: Colors.white,
                          text: "Chi tiết doanh thu",
                        );
                      }
                      return Row(
                        children: [
                          Flexible(
                            child: AppButton(
                              isCheckLastPress: false,
                              isEnable: true,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                cancelReasonTable(orderCubit);
                              },
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              borderSide: const BorderSide(color: Colors.red),
                              text: "Huỷ đơn",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: AppButton(
                              isCheckLastPress: false,
                              isEnable: true,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (state.order != null) {
                                  orderCubit.confirmOrder(widget.id);
                                }
                              },
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              backgroundColor: AppColors.primary,
                              textColor: Colors.white,
                              borderSide:
                                  const BorderSide(color: AppColors.primary),
                              text: "Nhận đơn",
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                body: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OrderDetail(
                          orderCubit: orderCubit,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            if (state.cancelState.isLoading || state.confirmState.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}

class OrderDetail extends StatelessWidget {
  final OrderCubit orderCubit;
  const OrderDetail({super.key, required this.orderCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: orderCubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconItemOrder(
                    image: AppAssets.imagesIconsIconUserCheck,
                    imageCheck: AppAssets.imagesIconsIconUserCheck,
                    isCheck: true,
                    time: state.order!.createdAt.formatHHMM(),
                  ),
                  const Flexible(
                    child: SizedBox(
                      height: 44,
                      child: Center(
                        child: Divider(
                          thickness: 2,
                          height: 40,
                          color: Color(0xffB9B9B9),
                        ),
                      ),
                    ),
                  ),
                  IconItemOrder(
                    isCheck: state.order!.getActiveActivityConfirmed() != null,
                    isCancelled:
                        state.order!.getOrderStatus()?.isCancelled == true,
                    image: AppAssets.imagesIconsIconStore,
                    imageCheck: AppAssets.imagesIconStoreCheck,
                    imageCancel: AppAssets.imagesIconsMerchantCancel,
                    time: state.order
                            ?.getActiveActivityConfirmed()
                            ?.createdAt
                            ?.formatHHMM() ??
                        "",
                  ),
                  const Flexible(
                    child: SizedBox(
                      height: 44,
                      child: Center(
                        child: Divider(
                          thickness: 2,
                          height: 40,
                          color: Color(0xffB9B9B9),
                        ),
                      ),
                    ),
                  ),
                  IconItemOrder(
                    image: AppAssets.imagesIconsIconDriver,
                    imageCheck: AppAssets.imagesIconsIconDriverCheck,
                    imageCancel: AppAssets.imagesIconsDriverIcon,
                    isCancelled:
                        state.order!.getOrderStatus()?.isCancelled == true,
                    isCheck: state.order!.getActiveActivityInDelivery() != null,
                    time: state.order
                            ?.getActiveActivityDriverAccepted()
                            ?.createdAt
                            ?.formatHHMM() ??
                        "",
                  ),
                  const Flexible(
                    child: SizedBox(
                      height: 44,
                      child: Center(
                        child: Divider(
                          thickness: 2,
                          height: 40,
                          color: Color(0xffB9B9B9),
                        ),
                      ),
                    ),
                  ),
                  IconItemOrder(
                    image: AppAssets.imagesIconsIconLocation,
                    imageCheck: AppAssets.imagesIconsIconLocationCheck,
                    imageCancel: AppAssets.imagesIconsLocationCancel,
                    isCheck: state.order?.getActiveActivityDelivered() != null,
                    isCancelled:
                        state.order!.getOrderStatus()?.isCancelled == true,
                    time: state.order
                            ?.getActiveActivityDelivered()
                            ?.createdAt
                            ?.formatHHMM() ??
                        "",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InfoCustomer(
                avatar: state.order!.getCustomerAvatar(),
                name: state.order!.getCustomerName(),
                phone: state.order!.getCustomerPhone(),
                suffix: GestureDetector(
                  onTap: () {
                    launchUrl(
                        Uri.parse('tel:${state.order!.getCustomerPhone()}'));
                  },
                  child: const ImageAssetWidget(
                    image: AppAssets.imagesIconsPhoneCall,
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InfoCustomer(
                name: state.order!.getDriverName(),
                phone: state.order!.getDriverPhone(),
                avatar: state.order!.getDriverAvatar(),
                role: Role.driver,
                suffix: GestureDetector(
                  onTap: () {
                    launchUrl(
                        Uri.parse('tel:${state.order!.getCustomerPhone()}'));
                  },
                  child: const ImageAssetWidget(
                    image: AppAssets.imagesIconsPhoneCall,
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SumaryOrder(
                orderCubit: orderCubit,
              ),
              const SizedBox(height: 10),
              if (state.order!.notes != null && state.order!.notes!.isNotEmpty)
                NoteCustomer(
                  note: 'Ghi chú',
                  body: state.order!.notes ?? "",
                ),
              const SizedBox(height: 10),
              PaymentInfo(
                orderCubit: orderCubit,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.borderColor2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 10),
                        Flexible(
                          child: ExpandablePanel(
                            header: Text(
                              'Thông tin đơn hàng',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            expanded: const SizedBox(),
                            collapsed: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                PaymentValue(
                                  title: 'Mã đơn hàng',
                                  price: '...',
                                  priceStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xffE15D33)),
                                ),
                                const SizedBox(height: 10),
                                PaymentValue(
                                    title: 'Thời gian đặt hàng',
                                    price:
                                        state.order!.createdAt!.formatHHMMDD()),
                                const SizedBox(height: 10),
                                const PaymentValue(
                                  title: 'Thời gian Lấy hàng dự kiến',
                                  price: '...',
                                ),
                                const SizedBox(height: 10),
                                const PaymentValue(
                                  title: 'Thời gian giao hàng dự kiến',
                                  price: '...',
                                ),
                              ],
                            ),
                            theme: const ExpandableThemeData(
                              iconPadding: EdgeInsets.all(0),
                              iconColor: Color(0xff131A29),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (state.order?.getOrderStatus()?.isCancelled == true)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.borderColor2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 10),
                          Flexible(
                            child: ExpandablePanel(
                              header: Text(
                                'Chi tiết huỷ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              expanded: const SizedBox(),
                              collapsed: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const PaymentValue(
                                    title: 'Số tiền hoàn lại',
                                    price: '...',
                                  ),
                                  const SizedBox(height: 10),
                                  PaymentValue(
                                    title: 'Huỷ bởi',
                                    price: state.order!
                                            .getActiveActivityCancel()
                                            ?.cancellationType ??
                                        '',
                                  ),
                                  const SizedBox(height: 10),
                                  PaymentValue(
                                    title: 'Thời gian huỷ',
                                    price: state.order!
                                            .getActiveActivityCancel()
                                            ?.cancellationTime() ??
                                        '',
                                  ),
                                  const SizedBox(height: 10),
                                  PaymentValue(
                                    title: 'Lý do huỷ',
                                    price: state.order!
                                            .getActiveActivityCancel()
                                            ?.cancellationReason ??
                                        '',
                                  ),
                                ],
                              ),
                              theme: const ExpandableThemeData(
                                iconPadding: EdgeInsets.all(0),
                                iconColor: Color(0xff131A29),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class PaymentValue extends StatelessWidget {
  final String title;
  final String price;
  final TextStyle? priceStyle;
  const PaymentValue({
    super.key,
    required this.title,
    required this.price,
    this.priceStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                color: AppColors.color373,
                fontWeight: FontWeight.w400,
              ),
        ),
        Text(
          price,
          style: priceStyle ??
              Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
        ),
      ],
    );
  }
}

void cancelReasonTable(OrderCubit orderCubit) {
  CancelModel? selectedReason;

  final textController = TextEditingController();

  Get.bottomSheet(
    StatefulBuilder(builder: (context, setState) {
      return BlocBuilder<OrderCubit, OrderState>(
        bloc: orderCubit,
        builder: (context, state) {
          return Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Text("Lý do từ chối",
                            textAlign: TextAlign.center,
                            style: Get.textTheme.titleMedium!),
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(height: 8),
                              BlocBuilder<OrderCubit, OrderState>(
                                  bloc: orderCubit,
                                  builder: (context, state) {
                                    return Column(
                                      children:
                                          state.listCancelOrder.map((item) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedReason = item;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    icon: selectedReason == item
                                                        ? Icon(
                                                            Icons
                                                                .radio_button_checked,
                                                            color: Get.theme
                                                                .primaryColor,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .radio_button_unchecked,
                                                            color: Colors.grey,
                                                          ),
                                                    onPressed: () {
                                                      setState(() {
                                                        selectedReason = item;
                                                      });
                                                    },
                                                  ),
                                                  Flexible(
                                                    child: Text(item.name,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: AppColors
                                                                    .color054)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  }),
                              selectedReason?.name == 'Lý do khác'
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: AppTextFormField(
                                        isRequired: true,
                                        controller: textController,
                                        hintText: 'Nhập lý do',
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: AppButton(
                            isCheckLastPress: false,
                            isEnable: true,
                            onPressed: () {
                              Get.back();
                            },
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            backgroundColor: Colors.white,
                            textColor: Colors.red,
                            borderSide: const BorderSide(color: Colors.red),
                            text: "Không",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                            child: AppButton(
                          isEnable: true,
                          onPressed: () {
                            if (selectedReason == null) {
                              Fluttertoast.showToast(
                                msg: 'Vui lòng chọn lý do',
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                              );
                            } else if (selectedReason?.name == 'Lý do khác' &&
                                textController.text == '') {
                              Fluttertoast.showToast(
                                msg: 'Vui lòng điền lý do',
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                              );
                            } else if (selectedReason?.name == 'Lý do khác' &&
                                textController.text != '') {
                              Get.back();
                            } else {
                              Get.back();
                            }
                            orderCubit.cancelById(
                                orderCubit.state.order!.id!,
                                selectedReason?.name == 'Lý do khác'
                                    ? textController.text
                                    : selectedReason!.name);
                          },
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          backgroundColor: AppColors.primary,
                          textColor: Colors.white,
                          text: "Xác nhận huỷ",
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }),
  );
}
