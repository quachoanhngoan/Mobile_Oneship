import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/page/order/bloc/order_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/info_customer.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/note_customer.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/order_revenue.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/payment_info.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/sumary_order.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderCubit orderCubit;
  @override
  void initState() {
    orderCubit = injector<OrderCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: orderCubit,
      builder: (context, state) {
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
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: SafeArea(
              child: Builder(builder: (context) {
                return AppButton(
                  isCheckLastPress: false,
                  isEnable: true,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Get.to(() => const OrderRevenue());
                  },
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.white,
                  textColor: Colors.red,
                  borderSide: const BorderSide(color: Colors.red),
                  text: "Huỷ đơn",
                );
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
                        },
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        backgroundColor: AppColors.primary,
                        textColor: Colors.white,
                        borderSide: const BorderSide(color: AppColors.primary),
                        text: "Nhận đơn",
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          body: const Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 50),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OrderDetail(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconItemOrder(
                image: AppAssets.imagesIconsIconUserCheck,
                imageCheck: AppAssets.imagesIconsIconUserCheck,
                isCheck: true,
              ),
              Flexible(
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
                isCheck: true,
                image: AppAssets.imagesIconsIconStore,
                imageCheck: AppAssets.imagesIconStoreCheck,
              ),
              Flexible(
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
                isCheck: true,
              ),
              Flexible(
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
              const IconItemOrder(
                image: AppAssets.imagesIconsIconLocation,
                imageCheck: AppAssets.imagesIconsIconLocationCheck,
                isCheck: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          InfoCustomer(
            name: 'Nguyễn Văn A',
            phone: '0123456789',
            suffix: const ImageAssetWidget(
              image: AppAssets.imagesIconsPhoneCall,
              width: 30,
            ),
          ),
          const SizedBox(height: 10),
          InfoCustomer(
            role: Role.driver,
            suffix: const ImageAssetWidget(
              image: AppAssets.imagesIconsPhoneCall,
              width: 30,
            ),
          ),
          const SizedBox(height: 10),
          const SumaryOrder(),
          const SizedBox(height: 10),
          const NoteCustomer(
            note: 'Lấy đồ ở cổng chính',
            body: 'Không đường, không đá, không topping',
          ),
          const SizedBox(height: 10),
          const PaymentInfo(),
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            PaymentValue(
                              title: 'Mã đơn hàng',
                              price: '123456',
                              priceStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffE15D33)),
                            ),
                            const SizedBox(height: 10),
                            const PaymentValue(
                              title: 'Thời gian đặt hàng',
                              price: 'Hôm nay, 12:00',
                            ),
                            const SizedBox(height: 10),
                            const PaymentValue(
                              title: 'Thời gian Lấy hàng dự kiến',
                              price: 'Hôm nay, 12:00',
                            ),
                            const SizedBox(height: 10),
                            const PaymentValue(
                              title: 'Thời gian giao hàng dự kiến',
                              price: 'Hôm nay, 12:00',
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
  }
}

class IconItemOrder extends StatelessWidget {
  final String image;
  final String imageCheck;
  final bool isCheck;
  const IconItemOrder({
    super.key,
    this.image = AppAssets.imagesIconsUserOrder,
    this.imageCheck = AppAssets.imagesIconsCheckIcon,
    this.isCheck = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ImageAssetWidget(
                image: isCheck ? imageCheck : image,
                width: 35,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ImageAssetWidget(
                    image: AppAssets.imagesIconsCheckIcon,
                    width: isCheck ? 16 : 0),
              ),
            ),
          ],
        ),
        Text(
          '12:00',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                color: isCheck == false ? AppColors.color194 : null,
              ),
        ),
      ],
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
  String? selectedReason;

  final textController = TextEditingController();

  Get.bottomSheet(
    StatefulBuilder(builder: (context, setState) {
      return Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                              children: state.listCancelOrder.map((item) {
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
                                                    Icons.radio_button_checked,
                                                    color:
                                                        Get.theme.primaryColor,
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
                                            child: Text(item,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                      selectedReason == 'OTHER_REASON'
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextField(
                                cursorColor:
                                    Theme.of(context).colorScheme.primary,
                                cursorHeight: 25,
                                controller: textController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    labelText: 'Lý do khác...',
                                    labelStyle:
                                        const TextStyle(fontSize: 12.5)),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      const Divider(),
                    ],
                  ),
                ),
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
                        } else if (selectedReason == 'OTHER_REASON' &&
                            textController.text == '') {
                          Fluttertoast.showToast(
                            msg: 'Vui lòng điền lý do',
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                          );
                        } else if (selectedReason == 'OTHER_REASON' &&
                            textController.text != '') {
                          Get.back();
                        } else {
                          Get.back();
                        }
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
    }),
  );
}
