import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/extensions/time_extention.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_request.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_date.dart';
import 'package:oneship_merchant_app/presentation/widget/images/form_upload_image.dart';

class StepRepresentativeInformation extends StatefulWidget {
  final RegisterStoreCubit bloc;
  const StepRepresentativeInformation({super.key, required this.bloc});

  @override
  State<StepRepresentativeInformation> createState() =>
      _StepRepresentativeInformationState();
}

class _StepRepresentativeInformationState
    extends State<StepRepresentativeInformation> {
  // final ValueNotifier<int> indexStack = ValueNotifier(0);
  late RegisterStoreCubit bloc;
  @override
  void initState() {
    // TODO: implement initState
    bloc = widget.bloc;
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
            child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
              bloc: bloc,
              builder: (context, state) {
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
                        bloc.setRepresentative(
                          state.representative?.copyWith(type: item),
                        );
                        bloc.dateController.clear();
                      },
                      child: Row(
                        children: [
                          state.representative?.type == item
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
            bloc: widget.bloc,
            builder: (context, state) {
              final snapshot = state.representative?.type ==
                      ERepresentativeInformation.individual
                  ? 0
                  : state.representative?.type ==
                          ERepresentativeInformation.businessHousehold
                      ? 1
                      : 2;
              return Flexible(
                child: IndexedStack(
                  index: snapshot,
                  children: [
                    Individual(bloc: widget.bloc),
                    BusinessHousehold(bloc: widget.bloc),
                    Business(bloc: bloc),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Individual extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const Individual({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextFormField(
                  isRequired: true,
                  hintText: 'Nhập Họ và tên người đại diện',
                  initialValue: state.representative?.name,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(name: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: true,
                  initialValue: state.representative?.phone,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(phone: p0),
                    );
                  },
                  hintText: 'Nhập số điện thoại',
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: false,
                  initialValue: state.representative?.otherPhone,
                  hintText: 'Nhập số điện thoại khác',
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(otherPhone: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: false,
                  hintText: 'Nhập email',
                  initialValue: state.representative?.email,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(email: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  initialValue: state.representative?.personalTaxCode,
                  isRequired: true,
                  hintText: 'Nhập mã số thuế cá nhân',
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(personalTaxCode: p0),
                    );
                  },
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
                        initialImage:
                            state.representative?.identityCardFrontImageId,
                        onUploadedImage: (file) {
                          bloc.setRepresentative(state.representative?.copyWith(
                            identityCardFrontImageId: file,
                          ));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: FormUploadImage(
                        title: 'Mặt sau CMND/CCCD/Hộ chiếu',
                        initialImage:
                            state.representative?.identityCardBackImageId,
                        onUploadedImage: (file) {
                          bloc.setRepresentative(state.representative?.copyWith(
                            identityCardBackImageId: file,
                          ));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                AppTextFormField(
                  isRequired: true,
                  filled: true,
                  initialValue: state.representative?.identityCard,
                  hintText: 'Nhập số CCCD/CMND/Hộ chiếu',
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(identityCard: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final pickerDate = await picker.DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime.now(),
                      onChanged: (date) {},
                      onConfirm: (date) {},
                      currentTime: DateTime.now(),
                      locale: LocaleType.vi,
                    );
                    if (pickerDate != null) {
                      bloc.setRepresentative(
                        state.representative
                            ?.copyWith(identityCardDate: pickerDate.toString()),
                      );
                      bloc.dateController.text = pickerDate.toFormatDate();
                    }
                  },
                  child: AppTextFormFieldDate(
                    onTap: () {},
                    controller: bloc.dateController,
                    hintText: 'Nhập ngày cấp',
                    enabled: false,
                    isRequired: true,
                    filled: true,
                    onChanged: (p0) {
                      bloc.setRepresentative(
                        state.representative?.copyWith(identityCardDate: p0),
                      );
                    },
                    // initialValue: state.representative.,
                  ),
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  filled: true,
                  isRequired: true,
                  hintText: 'Nhập nơi cấp',
                  initialValue: state.representative?.identityCardPlace,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(identityCardPlace: p0),
                    );
                  },
                ),
                const SizedBox(
                  height: 45,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BusinessHousehold extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const BusinessHousehold({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextFormField(
                  isRequired: true,
                  initialValue: state.representative?.name,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(name: p0),
                    );
                  },
                  hintText: 'Nhập họ và tên người đại diện',
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: true,
                  hintText: 'Nhập số điện thoại',
                  initialValue: state.representative?.phone,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(phone: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: false,
                  hintText: 'Nhập số điện thoại khác',
                  initialValue: state.representative?.otherPhone,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(otherPhone: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: false,
                  hintText: 'Nhập email',
                  initialValue: state.representative?.email,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(email: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: true,
                  initialValue: state.representative?.address,
                  hintText: 'Nhập địa chỉ kinh doanh',
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(address: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: true,
                  initialValue: state.representative?.businessName,
                  hintText: 'Nhập tên hộ kinh doanh',
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(businessName: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: true,
                  initialValue: state.representative?.taxCode,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(taxCode: p0),
                    );
                  },
                  hintText: 'Nhập mã số thuế',
                ),
                const SizedBox(height: 12),
                //FormUploadImage
                RichText(
                  text: TextSpan(
                    text: 'Ảnh chụp giấy phép kinh doanh',
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
                        title: '550 x 500px. Tối đa 1MB',
                        initialImage:
                            state.representative?.businessLicenseImageId,
                        onUploadedImage: (file) {
                          bloc.setRepresentative(state.representative?.copyWith(
                            businessLicenseImageId: file,
                          ));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: SizedBox(
                        width: Get.width,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Ảnh chụp giấy tờ liên quan',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                              color: AppColors.textColor,
                            ),
                        children: [],
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                      size: 19,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: FormUploadImage(
                        title: '550 x 500px. Tối đa 1MB',
                        initialImage: state.representative?.relatedImageId,
                        onUploadedImage: (file) {
                          bloc.setRepresentative(state.representative?.copyWith(
                            relatedImageId: file,
                          ));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: SizedBox(
                        width: Get.width,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                const SizedBox(
                  height: 45,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Business extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const Business({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextFormField(
                  isRequired: true,
                  initialValue: state.representative?.name,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(name: p0),
                    );
                  },
                  hintText: 'Nhập họ và tên người đại diện',
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: true,
                  hintText: 'Nhập số điện thoại',
                  initialValue: state.representative?.phone,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(phone: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: false,
                  hintText: 'Nhập số điện thoại khác',
                  initialValue: state.representative?.otherPhone,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(otherPhone: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: false,
                  hintText: 'Nhập email',
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(email: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  initialValue: state.representative?.address,
                  isRequired: true,
                  hintText: 'Nhập địa chỉ công ty',
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(address: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: true,
                  initialValue: state.representative?.businessName,
                  hintText: 'Nhập tên công ty',
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(businessName: p0),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AppTextFormField(
                  isRequired: true,
                  initialValue: state.representative?.taxCode,
                  onChanged: (p0) {
                    bloc.setRepresentative(
                      state.representative?.copyWith(taxCode: p0),
                    );
                  },
                  hintText: 'Nhập mã số thuế',
                ),
                const SizedBox(height: 12),
                //FormUploadImage
                RichText(
                  text: TextSpan(
                    text: 'Ảnh chụp giấy phép kinh doanh',
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
                        initialImage:
                            state.representative?.businessLicenseImageId,
                        title: '550 x 500px. Tối đa 1MB',
                        onUploadedImage: (file) {
                          bloc.setRepresentative(state.representative?.copyWith(
                            businessLicenseImageId: file,
                          ));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: SizedBox(
                        width: Get.width,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Ảnh chụp giấy tờ liên quan',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                              color: AppColors.textColor,
                            ),
                        children: [],
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                      size: 19,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: FormUploadImage(
                        initialImage: state.representative?.relatedImageId,
                        title: '550 x 500px. Tối đa 1MB',
                        onUploadedImage: (file) {
                          bloc.setRepresentative(state.representative?.copyWith(
                            relatedImageId: file,
                          ));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: SizedBox(
                        width: Get.width,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                const SizedBox(
                  height: 45,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
