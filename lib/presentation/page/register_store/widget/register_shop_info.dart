import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/extensions/string_extention.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';

import '../../register/register_page.dart';

class RegisterShopInfo extends StatelessWidget {
  final TextEditingController nameStoreController;
  final TextEditingController specialDishController;
  final TextEditingController streetNameController;
  final TextEditingController phoneContactController;
  final TextEditingController groupServiceController;
  final TextEditingController providerController;
  final TextEditingController districtController;
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
      required this.bloc,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const VSpacing(spacing: 20),
            TextFieldPassRegister(
              controller: nameStoreController,
              hintText: "Nhập tên cửa hàng",
              iSHintTextVisible: state.showHintNameStore,
              onChange: (value) {
                bloc.nameStoreVerify(value);
              },
              horizontalPadding: 0,
            ),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
                controller: specialDishController,
                hintText: "Nhập món đặc trưng của quán",
                iSHintTextVisible: true,
                onChange: (value) {},
                isStarRed: false,
                horizontalPadding: 0),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
                controller: streetNameController,
                hintText: "Nhập tên đường",
                iSHintTextVisible: true,
                onChange: (value) {},
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
                controller: phoneContactController,
                hintText: "Số điện thoại liên hệ",
                iSHintTextVisible: true,
                onChange: (value) {},
                horizontalPadding: 0,
                suffix: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 16,
                      color: AppColors.black.withOpacity(0.6),
                    ))),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
              controller: groupServiceController,
              hintText: "Nhóm dịch vụ",
              iSHintTextVisible: true,
              onChange: (value) {},
              horizontalPadding: 0,
              specialPrefix: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 16,
                          color: AppColors.black.withOpacity(0.6),
                        )),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.expand_more,
                        color: AppColors.color2B3, size: 24),
                  )
                ],
              ),
            ),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
              controller: providerController,
              hintText: "Nhập tỉnh/thành phố",
              iSHintTextVisible: true,
              onChange: (value) {},
              horizontalPadding: 0,
              specialPrefix: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 16,
                          color: AppColors.black.withOpacity(0.6),
                        )),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.expand_more,
                        color: AppColors.color2B3, size: 24),
                  )
                ],
              ),
            ),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
              controller: districtController,
              hintText: "Nhập quận/huyện",
              iSHintTextVisible: true,
              onChange: (value) {},
              horizontalPadding: 0,
              specialPrefix: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 16,
                          color: AppColors.black.withOpacity(0.6),
                        )),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.expand_more,
                        color: AppColors.color2B3, size: 24),
                  )
                ],
              ),
            ),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
              controller: streetAddressController,
              hintText: "Nhập số nhà và đường/Phố",
              iSHintTextVisible: true,
              horizontalPadding: 0,
              onChange: (value) {},
            ),
            const VSpacing(spacing: 16),
            TextFieldPassRegister(
              controller: parkingFeeController,
              hintText: "Nhập phí gửi xe",
              iSHintTextVisible: true,
              onChange: (value) {},
              horizontalPadding: 0,
              isStarRed: false,
            ),
            const VSpacing(spacing: 20),
          ],
        ),
      ),
    );
  }
}
