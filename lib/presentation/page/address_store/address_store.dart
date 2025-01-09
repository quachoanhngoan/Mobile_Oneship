import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';

import 'edit_address.dart';

class AddressStorePage extends StatefulWidget {
  const AddressStorePage({super.key});

  @override
  State<AddressStorePage> createState() => _AddressStorePageState();
}

class _AddressStorePageState extends State<AddressStorePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBarAuth(
          title: "Địa chỉ",
        ),
        body: Column(
          children: [
            _AddressITem(),
            SizedBox(
              height: 5,
            ),
            _AddressITem(),
          ],
        ));
  }
}

class _AddressITem extends StatelessWidget {
  const _AddressITem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const EditAddressPage());
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Địa chỉ nhận hàng",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textGray2,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "64/32 Nguyễn Văn Cừ, Quận. Phú Nhuận, Thành phố Hồ Chí Minh",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xffE15D33),
                  width: 1,
                ),
              ),
              child: Text(
                "Nhận hàng",
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
  }
}
