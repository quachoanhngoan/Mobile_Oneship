import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/address.model.dart';
import 'package:oneship_merchant_app/presentation/page/address_store/bloc/edit_address_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';

import 'edit_address.dart';

class AddressStorePage extends StatefulWidget {
  const AddressStorePage({super.key});

  @override
  State<AddressStorePage> createState() => _AddressStorePageState();
}

class _AddressStorePageState extends State<AddressStorePage> {
  late EditAddressBloc _editAddressBloc;
  @override
  void initState() {
    _editAddressBloc = injector.get<EditAddressBloc>();
    _editAddressBloc.getAddresss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBarAuth(
          title: "Địa chỉ",
        ),
        body: BlocBuilder<EditAddressBloc, EditAddressState>(
          bloc: _editAddressBloc,
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.addressStores.length,
              itemBuilder: (context, index) {
                return _AddressITem(
                  address: state.addressStores[index],
                );
              },
            );
          },
        ));
  }
}

class _AddressITem extends StatelessWidget {
  final AddressStoreM? address;
  const _AddressITem({
    super.key,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EditAddressPage(
              address: address,
            ));
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
                        address?.store?.name ?? "",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textGray2,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        address?.address ?? "",
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
                        "${address?.store?.name ?? ""} | ${address?.store?.phoneNumber ?? ""}",
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
                address?.getNameAddresss() ?? "",
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
