import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/info_customer.dart';
import 'package:oneship_merchant_app/presentation/page/order/widget/note_customer.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAuth(
        title: 'Order Page',
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
          child: Row(
            children: [
              Flexible(
                child: AppButton(
                  isCheckLastPress: false,
                  isEnable: true,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.white,
                  textColor: Colors.red,
                  borderSide: const BorderSide(color: Colors.red),
                  text: "Huỷ đơn",
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: AppButton(
                  isCheckLastPress: false,
                  isEnable: true,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  borderSide: const BorderSide(color: AppColors.primary),
                  text: "Nhận đơn",
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OrderDetail(),
            ],
          ),
        ),
      ),
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
            children: [
              Column(
                children: [
                  Text('12:00',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Text('12:00', style: TextStyle(fontSize: 20)),
                  Icon(Icons.store, color: Colors.orange),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Text('12:00', style: TextStyle(fontSize: 20)),
                  Icon(Icons.delivery_dining, color: Colors.orange),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Text('12:00', style: TextStyle(fontSize: 20)),
                  Icon(Icons.location_on, color: Colors.orange),
                ],
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
                            SizedBox(
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
                                      color: Color(0xffE15D33)),
                            ),
                            const SizedBox(height: 10),
                            PaymentValue(
                              title: 'Thời gian đặt hàng',
                              price: 'Hôm nay, 12:00',
                            ),
                            const SizedBox(height: 10),
                            PaymentValue(
                              title: 'Thời gian Lấy hàng dự kiến',
                              price: 'Hôm nay, 12:00',
                            ),
                            const SizedBox(height: 10),
                            PaymentValue(
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
