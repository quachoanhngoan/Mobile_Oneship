import 'dart:io';

import 'package:dio/dio.dart' as dio2;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/detail_food_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/dashed_divider.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/menu_dishes_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/menu_dishes_state.dart';
import 'package:oneship_merchant_app/presentation/page/menu_dishes_custom/widget/time_sellect_sheet.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/widget/app_text_form_field_select.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field_multi.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

import '../../widget/images/form_upload_image.dart';
import '../../widget/images/network_image_loader.dart';
import '../login/widget/loading_widget.dart';
import 'model/time_sell_type.dart';

class MenuDishsCustomPage extends StatefulWidget {
  const MenuDishsCustomPage({super.key});

  @override
  State<MenuDishsCustomPage> createState() => _MenuDishsCustomPageState();
}

class _MenuDishsCustomPageState extends State<MenuDishsCustomPage> {
  late MenuDishesCubit bloc;

  @override
  void initState() {
    bloc = injector.get<MenuDishesCubit>();
    bloc.init(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;

    return BlocConsumer<MenuDishesCubit, MenuDishesState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.isCompleteSuccess) {
            context.popScreen(result: true);
            context.showToastDialog(arg != null
                ? "Cập nhật món ăn thành công"
                : "Thêm món ăn thành công");
          }
          if (state.isCompleteError != null) {
            context.showErrorDialog(state.isCompleteError!, context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.white,
                  surfaceTintColor: AppColors.white,
                  leading: IconButton(
                      onPressed: () {
                        context.popScreen();
                      },
                      icon:
                          const Icon(Icons.arrow_back, color: AppColors.black)),
                  title: Text(arg != null ? "Chỉnh sửa" : "Thêm món ăn",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const VSpacing(spacing: 8),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "Ảnh món ăn",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: "*",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.red))
                                        ])),
                                        const VSpacing(spacing: 4),
                                        Text(
                                          "Món có ảnh sẽ được khách đặt nhiều hơn.\nTỉ lệ ảnh yêu cầu là 1:1",
                                          overflow: TextOverflow.visible,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                        ),
                                        const VSpacing(spacing: 4),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "Hướng dẫn chụp ảnh",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: AppColors.color988,
                                                  ),
                                            ),
                                            const HSpacing(spacing: 4),
                                            const ImageAssetWidget(
                                                image:
                                                    AppAssets.imagesIconsIcBook,
                                                width: 14,
                                                height: 14)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  _ImageFood(
                                    imageDefault: arg != null
                                        ? (arg as DetailFoodResponse).imageId
                                        : null,
                                    onUploadedImage: (value) {
                                      bloc.updateImage(value);
                                    },
                                  )
                                ],
                              ),
                              const VSpacing(spacing: 16),
                              DashedDivider(
                                  color: AppColors.textGray.withOpacity(0.3)),
                              const VSpacing(spacing: 12),
                              RegisterStoreFormField(
                                controller: bloc.nameFoodController,
                                isRequired: true,
                                hintText: "Tên món ăn",
                                onChanged: (value) {
                                  bloc.validateNameFood();
                                },
                                suffix: state.isShowClearNameFood
                                    ? IconButton(
                                        onPressed: () {
                                          bloc.nameFoodController.clear();
                                          bloc.validateNameFood();
                                        },
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          size: 16,
                                          color:
                                              AppColors.black.withOpacity(0.6),
                                        ))
                                    : const SizedBox.shrink(),
                              ),
                              const VSpacing(spacing: 8),
                              RegisterStoreFormField(
                                controller: bloc.priceController,
                                isRequired: true,
                                hintText: "Giá bán",
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                      trailingSymbol: ' vnđ', mantissaLength: 0)
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  bloc.validatePriceFood();
                                },
                                suffix: state.isShowClearPrice
                                    ? IconButton(
                                        onPressed: () {
                                          bloc.priceController.clear();
                                          bloc.validatePriceFood();
                                        },
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          size: 16,
                                          color:
                                              AppColors.black.withOpacity(0.6),
                                        ))
                                    : const SizedBox.shrink(),
                              ),
                              const VSpacing(spacing: 8),
                              AppTextFormFieldSelect(
                                controller: bloc.categoryController,
                                isRequired: true,
                                hintText: "Chọn danh mục",
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return _ListCategoryStore(bloc: bloc);
                                      });
                                },
                                suffixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    state.isShowClearCategory
                                        ? GestureDetector(
                                            onTap: () {
                                              bloc.categoryStoreSellectClear();
                                            },
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              size: 16,
                                              color: AppColors.black
                                                  .withOpacity(0.6),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    const HSpacing(spacing: 6),
                                    const Icon(Icons.expand_more,
                                        color: AppColors.color2B3, size: 24),
                                  ],
                                ),
                              ),
                              const VSpacing(spacing: 16),
                              AppTextFormFieldMulti(
                                  controller: bloc.descriptionController,
                                  hintText:
                                      "Nhập mô trả để khách hàng hiểu hơn về món ăn"),
                              const VSpacing(spacing: 20),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Chọn giờ bán sản phẩm",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12)),
                                TextSpan(
                                    text: "*",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.red,
                                            fontSize: 12))
                              ])),
                              const VSpacing(spacing: 8),
                              Row(
                                children: List.generate(
                                    TimeSellType.values.length, (index) {
                                  final item = TimeSellType.values[index];
                                  final isSellect = state.typeTime == item;

                                  return GestureDetector(
                                    onTap: () {
                                      bloc.sellectTypeTimeSell(item);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 50),
                                      color: AppColors.transparent,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 16,
                                            height: 16,
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: isSellect
                                                    ? AppColors.colorFF9
                                                    : AppColors.transparent,
                                                border: Border.all(
                                                    color: AppColors.color5DD)),
                                            child: isSellect
                                                ? Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.color05C,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                          const HSpacing(spacing: 8),
                                          Text(
                                            item.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.color054),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              if (state.typeTime ==
                                  TimeSellType.timeOption) ...[
                                const VSpacing(spacing: 16),
                                Divider(
                                    thickness: 1.2,
                                    height: 1,
                                    color: AppColors.textGray.withOpacity(0.3)),
                                const VSpacing(spacing: 12),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        useSafeArea: true,
                                        context: context,
                                        builder: (_) {
                                          return TimeSellectSheet(bloc: bloc);
                                        });
                                  },
                                  child: Container(
                                    color: AppColors.transparent,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Chọn giờ bán",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.textGray2),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.keyboard_arrow_right_outlined,
                                          color: AppColors.textGray2,
                                          size: 24,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              const VSpacing(spacing: 12),
                              Divider(
                                  thickness: 1.2,
                                  height: 1,
                                  color: AppColors.textGray.withOpacity(0.3)),
                              // const VSpacing(spacing: 4),
                              AppTextFormFieldSelect(
                                isRequired: false,
                                controller: bloc.toppingController,
                                hintText: "Chọn topping",
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return _LinkedFoodSheet(
                                          bloc: bloc,
                                        );
                                      });
                                },
                                suffixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    state.isShowClearTopping
                                        ? GestureDetector(
                                            onTap: () {
                                              bloc.toppingController.clear();
                                              bloc.listIdLinkFoodSellectClear();
                                            },
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              size: 16,
                                              color: AppColors.black
                                                  .withOpacity(0.6),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    const HSpacing(spacing: 6),
                                    const Icon(Icons.expand_more,
                                        color: AppColors.color2B3, size: 24),
                                  ],
                                ),
                              ),
                              const VSpacing(spacing: 30)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 0.3,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                      child: GestureDetector(
                        onTap: () {
                          if (state.isButtonNextEnable()) {
                            bloc.saveInfoClick();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: state.isButtonNextEnable()
                                  ? AppColors.color988
                                  : AppColors.color8E8,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Lưu thông tin",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: state.isButtonNextEnable()
                                        ? AppColors.white
                                        : AppColors.colorA4A),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: state.isLoading,
                child: const LoadingWidget(),
              )
            ],
          );
        });
  }
}

class _LinkedFoodSheet extends StatefulWidget {
  final MenuDishesCubit bloc;

  const _LinkedFoodSheet({required this.bloc});

  @override
  State<_LinkedFoodSheet> createState() => _LinkedFoodSheetState();
}

class _LinkedFoodSheetState extends State<_LinkedFoodSheet> {
  late MenuDishesCubit _bloc;

  @override
  initState() {
    _bloc = widget.bloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuDishesCubit, MenuDishesState>(
        bloc: _bloc,
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
                color: AppColors.color6F6,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            child: Column(
              children: <Widget>[
                const VSpacing(spacing: 12),
                Text(
                  "Topping liên kết",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const VSpacing(spacing: 12),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.listLinkFood.length,
                      itemBuilder: (context, index) {
                        final isSellectMainId = state.listIdLinkFoodSellected
                                .firstWhereOrNull((e) =>
                                    e.id == state.listLinkFood[index].id) !=
                            null;

                        final isShowDetail = state.listIdToppingShowDetail
                                    .firstWhereOrNull((e) =>
                                        e == state.listLinkFood[index].id) !=
                                null &&
                            state.listLinkFood[index].options.isNotEmpty ==
                                true;

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _bloc.listIdLinkFoodSellect(
                                      state.listLinkFood[index].id,
                                      isAll: true);
                                },
                                child: Container(
                                  color: AppColors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                            color: isSellectMainId
                                                ? AppColors.color988
                                                : AppColors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: isSellectMainId
                                                    ? AppColors.transparent
                                                    : AppColors.textGray,
                                                width: 1)),
                                        child: const Icon(
                                          Icons.check_outlined,
                                          color: AppColors.white,
                                          size: 12,
                                        ),
                                      ),
                                      const HSpacing(spacing: 8),
                                      Text(
                                        "${state.listLinkFood[index].name}(${state.listLinkFood[index].options.length})",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          _bloc.toppingShowOrHideDetail(
                                              state.listLinkFood[index].id);
                                        },
                                        child: Icon(
                                          state.listLinkFood[index].options
                                                      .isNotEmpty ==
                                                  true
                                              ? Icons
                                                  .keyboard_arrow_down_outlined
                                              : Icons
                                                  .keyboard_arrow_right_outlined,
                                          color: AppColors.textGray,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              isShowDetail
                                  ? const VSpacing(spacing: 6)
                                  : Container(),
                              isShowDetail
                                  ? Divider(
                                      color:
                                          AppColors.textGray.withOpacity(0.3),
                                      height: 16,
                                      thickness: 1.2)
                                  : Container(),
                              if (isShowDetail) ...[
                                ...List.generate(
                                    state.listLinkFood[index].options.length,
                                    (inxChild) {
                                  final childItem = state
                                      .listLinkFood[index].options[inxChild];
                                  final isSellectChildId = state
                                          .listIdLinkFoodSellected
                                          .firstWhereOrNull(
                                              (e) => e.id == childItem.id) !=
                                      null;
                                  return Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          _bloc.listIdLinkFoodSellect(
                                              childItem.id);
                                        },
                                        child: Container(
                                          color: AppColors.transparent,
                                          margin:
                                              const EdgeInsets.only(left: 30),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                    color: isSellectChildId
                                                        ? AppColors.color988
                                                        : AppColors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                        color: isSellectChildId
                                                            ? AppColors
                                                                .transparent
                                                            : AppColors
                                                                .textGray,
                                                        width: 1)),
                                                child: const Icon(
                                                  Icons.check_outlined,
                                                  color: AppColors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              const HSpacing(spacing: 8),
                                              Text(
                                                childItem.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      state.listLinkFood[index].options.length -
                                                  1 !=
                                              inxChild
                                          ? Divider(
                                              color: AppColors.textGray
                                                  .withOpacity(0.3),
                                              height: 16,
                                              thickness: 1.2)
                                          : Container()
                                    ],
                                  );
                                })
                              ]
                            ],
                          ),
                        );
                      }),
                ),
                const VSpacing(spacing: 8),
                Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 0.3,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _bloc.listIdLinkFoodSellectClear();
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: AppColors.color988)),
                              child: Text(
                                "Huỷ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.color988),
                              ),
                            ),
                          ),
                        ),
                        const HSpacing(spacing: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _bloc.listIdLinkFoodSellectConfirm();
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.color988,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Xác nhận",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
  }
}

class _ImageFood extends StatefulWidget {
  final ValueChanged<String> onUploadedImage;
  final String? imageDefault;

  const _ImageFood({required this.onUploadedImage, this.imageDefault});

  @override
  State<_ImageFood> createState() => _ImageFoodState();
}

class _ImageFoodState extends State<_ImageFood> {
  final ImagePicker _picker = ImagePicker();
  var isLoading = false;
  String image = '';
  List<XFile>? _mediaFileList;

  Future<String> uploadFileHTTP(
      String preSignedUrl, XFile pathFile, String contentType) async {
    final dio = injector<dio2.Dio>();
    final apiToken = prefManager.token;
    dio2.FormData formData = dio2.FormData.fromMap({
      'file': await dio2.MultipartFile.fromFile(
        pathFile.path,
        filename: '${pathFile.path.split('/').last}.jpg',
        contentType: dio2.DioMediaType('image', 'jpeg'),
      ),
    });
    dio.options.connectTimeout = const Duration(minutes: 1);
    dio.options.receiveTimeout = const Duration(minutes: 1);
    final response = await dio.post(
      preSignedUrl,
      data: formData,
      options: dio2.Options(
        headers: {
          'accept': '*/*',
          'Content-Type': 'multipart/form-data',
          "Authorization": "Bearer $apiToken",
        },
      ),
    );

    if ([200, 201, 202].contains(response.statusCode)) {
      return UploadResponse.fromJson(response.data).data?.id ?? '';
    }
    return '';
  }

  void uploadFile() async {
    if (_mediaFileList != null && _mediaFileList!.isNotEmpty) {
      try {
        isLoading = true;
        setState(() {});
        if (_mediaFileList!.isEmpty) {
          throw Exception('Chưa chọn ảnh');
        }
        final file = File(_mediaFileList!.first.path);

        int sizeInBytes = file.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 1) {
          throw Exception('Dung lượng ảnh không được lớn hơn 1MB');
        }
        final url = '${EnvManager.shared.api}/api/v1/uploads';
        final httpResponse = await uploadFileHTTP(
          url,
          _mediaFileList!.first,
          'image/jpeg',
        );
        image = httpResponse;
        print('httpResponse: $httpResponse');
        widget.onUploadedImage(httpResponse);
      } catch (e) {
        dialogService.showAlertDialog(
            title: "Lỗi",
            description: e.toString(),
            buttonTitle: "Đóng",
            onPressed: () {
              Get.back();
            });
      } finally {
        isLoading = false;

        setState(() {});
      }
    }
  }

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
              source: ImageSource.gallery, imageQuality: 70);
          _setImageFileListFromFile(pickedFile);
          uploadFile();
        } catch (e) {
          print(e);
        }
        setState(() {});
      },
      child: isLoading
          ? const SizedBox(
              height: 85,
              width: 85,
              child: CupertinoActivityIndicator(
                color: AppColors.primary,
              ),
            )
          : image.isNotEmpty
              ? SizedBox(
                  height: 85,
                  width: 85,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      NetworkImageWithLoader(
                        image,
                        isBaseUrl: true,
                        fit: BoxFit.cover,
                      ),
                      IntrinsicHeight(
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                              color: AppColors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(8))),
                          child: Text(
                            "Sửa",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 12, color: AppColors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : widget.imageDefault?.isNotEmpty == true
                  ? SizedBox(
                      height: 85,
                      width: 85,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          NetworkImageWithLoader(
                            widget.imageDefault!,
                            isBaseUrl: true,
                            fit: BoxFit.cover,
                          ),
                          IntrinsicHeight(
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.black.withOpacity(0.5),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(8))),
                              child: Text(
                                "Sửa",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 12, color: AppColors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: 85,
                      padding: const EdgeInsets.all(12),
                      width: 85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            if (isLoading) {
                              return const SizedBox(
                                width: 36,
                                height: 36,
                                child: CupertinoActivityIndicator(
                                  color: AppColors.primary,
                                ),
                              );
                            }
                            return const ImageAssetWidget(
                              image: AppAssets.imagesIconsCamera,
                              width: 36,
                              height: 36,
                            );
                          }),
                          const SizedBox(height: 4),
                          Text(
                            "Tối đa 1MB",
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodySmall!.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff9B9B9B),
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}

class _ListCategoryStore extends StatefulWidget {
  final MenuDishesCubit bloc;

  const _ListCategoryStore({super.key, required this.bloc});

  @override
  State<_ListCategoryStore> createState() => __ListCategoryStoreState();
}

class __ListCategoryStoreState extends State<_ListCategoryStore> {
  late MenuDishesCubit _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuDishesCubit, MenuDishesState>(
        bloc: _bloc,
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Column(
              children: <Widget>[
                const VSpacing(spacing: 12),
                Text("Danh mục quán",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const VSpacing(spacing: 12),
                Expanded(
                  child: state.listCategoryStore.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.listCategoryStore.length,
                          itemBuilder: (context, index) {
                            final item = state.listCategoryStore[index];
                            final isSellected =
                                state.categoryStoreSellect == item;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  const VSpacing(spacing: 12),
                                  GestureDetector(
                                    onTap: () {
                                      _bloc.sellectCategoryStore(item);
                                    },
                                    child: Container(
                                      color: AppColors.transparent,
                                      child: Row(
                                        children: <Widget>[
                                          const HSpacing(spacing: 16),
                                          Container(
                                            width: 16,
                                            height: 16,
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.transparent,
                                                border: Border.all(
                                                  color: AppColors.textGray,
                                                )),
                                            child: isSellected
                                                ? Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppColors.textGray,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                          const HSpacing(spacing: 8),
                                          Text(
                                            item.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const VSpacing(spacing: 4),
                                  Divider(
                                    color: AppColors.textGray.withOpacity(0.3),
                                    thickness: 1,
                                  )
                                ],
                              ),
                            );
                          })
                      : Container(),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 0.3,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                  child: GestureDetector(
                    onTap: () {
                      _bloc.confirmSellectCategoryGoo();
                      context.popScreen();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.color988,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Xác nhận",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
