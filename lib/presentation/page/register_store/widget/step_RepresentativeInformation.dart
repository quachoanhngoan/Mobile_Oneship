import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field.dart';
import 'package:oneship_merchant_app/presentation/widget/images/form_upload_image.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

enum ERepresentativeInformation {
  individual,
  businessHousehold,
  business,
  ;

  String get name {
    switch (this) {
      case ERepresentativeInformation.individual:
        return 'Cá nhân';
      case ERepresentativeInformation.business:
        return 'Doanh nghiệp';
      case ERepresentativeInformation.businessHousehold:
        return 'Hộ kinh doanh';
      default:
        return '';
    }
  }

  String get value {
    switch (this) {
      case ERepresentativeInformation.individual:
        return 'individual';
      case ERepresentativeInformation.business:
        return 'business';
      case ERepresentativeInformation.businessHousehold:
        return 'business_household';
      default:
        return '';
    }
  }
}

class StepRepresentativeInformation extends StatefulWidget {
  const StepRepresentativeInformation({super.key});

  @override
  State<StepRepresentativeInformation> createState() =>
      _StepRepresentativeInformationState();
}

class _StepRepresentativeInformationState
    extends State<StepRepresentativeInformation> {
  final ValueNotifier<int> indexStack = ValueNotifier(0);
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController phoneOtherController;
  late TextEditingController emailController;
  late TextEditingController taxCodeController;
  late TextEditingController businessAddressController;
  late TextEditingController businessNameController;

  @override
  void initState() {
    // TODO: implement initState

    nameController = TextEditingController();
    phoneController = TextEditingController();
    phoneOtherController = TextEditingController();
    emailController = TextEditingController();
    taxCodeController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ValueListenableBuilder<int>(
                valueListenable: indexStack,
                builder: (context, snapshot, _) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    // physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    itemCount: ERepresentativeInformation.values.length,
                    itemBuilder: (context, index) {
                      final item = ERepresentativeInformation.values[index];
                      return GestureDetector(
                        onTap: () {
                          indexStack.value = index;
                        },
                        child: Row(
                          children: [
                            snapshot == index
                                ? const Icon(
                                    Icons.radio_button_checked,
                                    color: AppColors.primary,
                                  )
                                : const Icon(
                                    Icons.radio_button_off,
                                    color: AppColors.borderColor,
                                  ),
                            const SizedBox(width: 8),
                            Text(
                              item.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
          ValueListenableBuilder<int>(
              valueListenable: indexStack,
              builder: (context, snapshot, _) {
                return Flexible(
                  child: IndexedStack(
                    index: snapshot,
                    children: [
                      const Individual(),
                      Container(),
                      Container(),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class Individual extends StatelessWidget {
  const Individual({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTextFormField(
              isRequired: true,
              hintText: 'Họ và tên người đại diện',
            ),
            const SizedBox(height: 8),
            const AppTextFormField(
              isRequired: true,
              hintText: 'Nhập số điện thoại',
            ),
            const SizedBox(height: 8),
            const AppTextFormField(
              isRequired: false,
              hintText: 'Nhập số điện thoại khác',
            ),
            const SizedBox(height: 8),
            const AppTextFormField(
              isRequired: true,
              hintText: 'Nhập email',
            ),
            const SizedBox(height: 8),
            const AppTextFormField(
              isRequired: false,
              hintText: 'Nhập mã số thuế cá nhân',
            ),
            const SizedBox(height: 12),
            //FormUploadImage
            RichText(
              text: TextSpan(
                text: 'Ảnh chụp CMND/CCCD/Hộ chiếu',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: AppColors.textColor,
                    ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          color: AppColors.red,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: FormUploadImage(
                    title: 'Mặt trước CMND/CCCD/Hộ chiếu',
                    onUploadedImage: (file) {
                      print(file);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: FormUploadImage(
                    title: 'Mặt sau CMND/CCCD/Hộ chiếu',
                    onUploadedImage: (file) {
                      print(file);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const AppTextFormField(
              isRequired: false,
              filled: true,
              hintText: 'Nhập số CCCD/CMND/Hộ chiếu',
            ),
            const SizedBox(height: 8),
            const AppTextFormField(
              hintText: 'Nhập ngày cấp',
              enabled: true,
              isRequired: true,
              filled: true,
            ),
            const SizedBox(height: 8),
            const AppTextFormField(
              filled: true,
              isRequired: true,
              hintText: 'Nhập nơi cấp',
            ),
            const SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
