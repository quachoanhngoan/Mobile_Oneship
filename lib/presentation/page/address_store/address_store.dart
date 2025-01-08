import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';

class AddressStorePage extends StatefulWidget {
  const AddressStorePage({super.key});

  @override
  State<AddressStorePage> createState() => _AddressStorePageState();
}

class _AddressStorePageState extends State<AddressStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBarAuth(
          title: "Địa chỉ",
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Địa chỉ nhận hàng",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textGray2,
                                  ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "64/32 Nguyễn Văn Cừ, Quận. Phú Nhuận, Thành phố Hồ Chí Minh",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    color: AppColors.color373,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Nguyễn Trần Hoàng Long  |  0901234567",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    color: AppColors.textGray2,
                                    fontWeight: FontWeight.w400,
                                  ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Sửa",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
